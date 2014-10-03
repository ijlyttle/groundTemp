# reference: 
#    http://en.wikipedia.org/wiki/December_solstice
#    http://en.wikipedia.org/wiki/Tropical_year
#
tropical_year <- 
  list(
    time_ref = lubridate::ymd_hms("2010-12-21 23:38:00", tz="UTC"),
    dtime_ref = as.numeric(lubridate::ddays(365.242189)) 
   )

use_data(tropical_year)