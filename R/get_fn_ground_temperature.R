#' get_fn_ground_temperature
#' 
#' Generate a function to model the ground temperature
#' 
#' The function will have arguements: instant, depth (m)
#' 
#' The function will return an estimated ground-temperature 
#' for the given instant(s) and depth
#' 
#' http://soilphysics.okstate.edu/software/SoilTemperature/document.pdf
#' 
#' @param   temp_ref     numeric, mean air temperature for the year (°C) 
#' @param   dtemp_ref    numeric, amplitude for mean daily air temperature (°C)
#' @param   time_ref     numeric,  number of days after solstice when min temperature (days) 
#' @param   diffusivity  (m^2/s) thermal diffusivity (default 1.e-6, P. Begeury suggestion)
#' 
#' @return function for ground-temperature
#' @export
#' 
get_fn_ground_temperature <- 
  function(temp_ref, dtemp_ref, time_ref, diffusivity = 1.e-6){  
     
  dtime_ref <- tropical_year$dtime_ref
  
  # define reference depth
  depth_ref <- sqrt(2*diffusivity*dtime_ref/(2*pi))
  
  # inst POSIXct datetime
  # depth (m)
  fn_tmp_ground <- function(inst, depth){
    
    # normalized depth
    depth_norm <- depth/depth_ref
    
    # phase
    phase <- 
      2*pi*as.numeric(difftime(inst, time_ref, units="sec"))/dtime_ref - 
      depth_norm - 
      pi/2
    
    temp <- temp_ref + dtemp_ref*exp(-depth_norm)*sin(phase)
    
    temp
  }
  
  return(fn_tmp_ground)
}
