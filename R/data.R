#' Insect sweep net data
#'
#' Counts of all insects
#'
#' @format A data.frame with 5 variables: \code{date}, \code{watershed},
#' \code{rep}, \code{taxa}, and \code{count}
#'
#' @seealso \code{\link{insect_guilds}}
#'
#' @examples
#' library(dplyr)
#' with_guild <- insect_count %>%
#'   left_join(insect_guild, by="taxa")
"insect_counts"

#' Insect guilds
#'
#'
#'
#' @format A data.frame with two variables: \code{taxa} and
#' \code{guild}
#'
#' @seealso \code{\link{insect_counts}}
#'
#' @examples
#' library(dplyr)
#' with_guild <- insect_count %>%
#'   left_join(insect_guilds, by="taxa")
"insect_guilds"
