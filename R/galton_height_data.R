#' Data from the famous 1885 study by Francis Galton exploring the relationship between the heights of adult children and the heights of their parents
#'
#' This dataset contains the heights of a sample of adult men and women and the heights of their parents from late 19th Century England. Each
#' row in the dataset represents a single subject in Galton's study. The dataset records the heights of 898 subjects who belonged to 197 different
#' families (this means the same parents can appear multiple times in the columns recording parental height).
#' 
#' @format A tibble with 898 rows and 6 columns:
#' \describe{
#'   \item{subject_height}{dbl The height of each subject in inches}
#'   \item{subject_father_height}{dbl The height of each subject's father in inches} 
#'   \item{subject_mother_height}{dbl The height of each subject's mother in inches}
#'   \item{subject_sex}{fct The sex of each subject}
#'   \item{family_id}{chr String indicating which family within the dataset each subject belonged to}
#'   \item{number_of_children_in_family}{dbl The total number of children within each family (not all of whom necessarily participated in Galton's study)}
#' }
#' @source \url{http://www.randomservices.org/random/data/Galton.html}
'galton_height_data'