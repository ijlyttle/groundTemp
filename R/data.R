#' Tropical year
#' 
#' Description of a tropical year.
#' 
#' @format A list with two members:
#' \describe{
#'   \item{time_ref}{POSIXct, instant describing December 2010 solstice}
#'   \item{dtime_ref}{numeric, length of a tropical year, in seconds}
#' }
#' 
#' @source \url{http://en.wikipedia.org/wiki/Tropical_year}
#' @source \url{http://en.wikipedia.org/wiki/December_solstice}
#' 
"tropical_year"

#' wx_2011
#' 
#' Weather dataset for 2011
#' 
#' @format A data frame of 8760 observations of 5 variables:
#' \describe{
#'   \item{instant}{POSIXct, time of the observation}
#'   \item{tmp_db}{numeric, dry-bulb temperature (°C)}
#'   \item{tmp_wb}{numeric, wet-bulb temperature, (°C)}
#'   \item{rel_humid}{numeric, relative humidity (1)}
#'   \iten{p_sl}{numeric, sea-level pressure (Pa)}
#' }
#' 
"wx_2011"