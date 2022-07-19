#' A tidyverse-friendly method of estimating robust population means and their uncertainty from survey datasets
#'
#' This function is a wrapper around robsurvey::svymean_trimmed() and robsurvey::svymean_winsorized() which is designed to allow them to work harmoniously with the
#' syntax of the tidyverse, borrowing ideas from the srvyr package. It is designed to be called from within dplyr functions like dplyr::summarise() or dplyr::mutate().
#'
#' @param x A survey design object.
#' @param method Choose the method to use to estimate the robust mean from a choice of either 'trim' for a trimemd mean or 'winsorize' for a winsorised mean. Default is 
#' 'trim'.
#' @param LB The lower bound to either trim or winsorize. See the documentation for the original functions in robsurvey for more information.
#' @param UB The uper bound to either trim or winsorize. As above.
#' @param na.rm Remove observations which have missing data before estimating the mean? Default is FALSE.
#' @param vartype The estimate of uncertainty to return. Default is 'se' for standard error of the mean.
#' @param ... Additional arguments to pass to robsurvey::svymean_trimmed or robsurvey::svymean_winsorized.
#' 
#' @return A tibble containing the estimated population parameter.
#' 
#' @export
robust_survey_mean <- function(x, method = c('trim', 'winsorize'), LB = 0, UB = 1, na.rm = FALSE, vartype = c('se', 'ci', 'var', 'cv'), ...) {
  
  if (missing(vartype)) vartype <- 'se'
  vartype <- match.arg(vartype, several.ok = TRUE)
  
  .svy <- srvyr::set_survey_vars(srvyr::cur_svy(), x)
  
  robust_mean <-
    if (method == 'trim') {
      robsurvey::svymean_trimmed(~`__SRVYR_TEMP_VAR__`, design = .svy, LB = LB, UB = UB, ...)
    } else if (method == 'winsorize') {
      robsurvey::svymean_winsorized(~`__SRVYR_TEMP_VAR__`, design = .svy, LB = LB, UB = UB, ...)
    }
  
  if (vartype != 'ci') {
    out <- srvyr::get_var_est(robust_mean, vartype)
  } else {
    mean <- coef(robust_mean)
    se <- robsurvey::SE.svystat_rob(robust_mean)[1,1]
    out <- tibble::tibble('coef' = mean, '_low' = mean - (1.96 * se), '_upp' =  mean + (1.96 * se))
  }
  
  out <- srvyr::as_srvyr_result_df(out)
  return(out)
  
}