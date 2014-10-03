#' ground_temp_coef
#' 
#' Given a vector on instants and a vector of air-temperautures, return a list of
#' coefficients for the surface temperature.
#' 
#' A sinusoid is fit to the time/tempurature pairs. 
#' The coefficients of the sine wave (temp_ref, dtemp_ref, time_ref) are returned.
#' 
#' http://soilphysics.okstate.edu/software/SoilTemperature/document.pdf
#' 
#' @param   instant     POSIXct instants 
#' @param   temp        numeric ambient air (dry-bulb) temperature
#' @param   n_hemi      logical, indicates fit for northern hemisphere
#' 
#' @return  list of coefficients
#' 
#' @import lubridate
#' @export
#' 
ground_temp_coef <- function(instant, temp, n_hemi = TRUE){
  
  # validation ideas:
  # length(instant) == length(time)
  # instants are POSIXct
  # temp are numeric
  
  dtime_ref <- tropical_year$dtime_ref
  time_ref_init <- tropical_year$time_ref
  
  if (!n_hemi){
    time_ref_init <- time_ref_init + dtime_ref/2 # delay guess by ~six months
  }
  
  temp_ref_init <- mean(temp)
  dtemp_ref_init <- sqrt(2)*sd(temp)
  
  # form of the equation
  formula <- 
    temp ~ temp_ref + dtemp_ref * sin(2*pi*(time - time_ref)/dtime_ref - pi/2)
  
  # initial guess for parameters
  init <- list(
    temp_ref = temp_ref_init,
    dtemp_ref = dtemp_ref_init,
    time_ref = time_ref_init
  )
  
  # construct data.frame
  df <- data.frame(time = as.numeric(instant), temp = temp)
  
  #  return(df)
  
  # determine model
  nls_model <- nls(formula = formula, data = df, start = init)
  
  # extract coefficients
  temp_ref <- unname(coef(nls_model)["temp_ref"])
  dtemp_ref <- unname(coef(nls_model)["dtemp_ref"])
  time_ref <- 
    as.POSIXct(
      unname(coef(nls_model)["dtemp_ref"]), 
      origin = lubridate::origin,
      tz = "UTC"
    )
  
  # return list
  list(temp_ref = temp_ref, dtemp_ref = dtemp_ref, time_ref = time_ref)  
  
}