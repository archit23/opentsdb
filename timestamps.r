#' Timestamps with suitable default formatting and timezone handling
#'
#' @note tz="" is equivalent to tz=Sys.timezone()
#'
#' @param   x       epoch time, character, or anything else convertable via \link{as.POSIXct}
#' @param   tz      character string (see link{timezones})
#' @param   origin  character string (see \link{as.POSIXct})
#' @param   ...     further arguments to be passed to or from other methods (example: format) 
#' @export
Timestamp <- function(x, tz, origin="1970-01-01 00:00:00", ...) {
    if (is.numeric(x)) {
        if (missing(tz)) {
            tz = "UTC"
            warning('No timezone given. Defaulting to UTC')
        }
        timestamp <- as.POSIXct(x, tz=tz, origin=origin)
    } else if (is.character(x)) {
        if (missing(tz)) {
            tz = ""
            warning('No timezone given. Defaulting to ""')
        }
        timestamp <- as.POSIXct(x, format="%Y-%m-%dT%H:%M:%S%z", tz=tz)
    } else if (inherits(x, "POSIXt")) {
        timestamp <- x
    } else {
        timestamp <- as.POSIXct(x, tz=tz)
    }
    class(timestamp) <- c(class(timestamp), 'Timestamp')
    return(timestamp)
}

format_iso8601 <- function(x, tz="", ...) {
    format.POSIXct(x, format="%Y-%m-%dT%H:%M:%S%z", tz=tz, usetz=FALSE)
}

format_local <- function(x, tz="", usetz=FALSE, ...) {
    format.POSIXct(x, format="%Y/%m/%d-%H:%M:%S", tz=tz, usetz=FALSE)
}

format_default <- function(x, tz="", ...) {
    format.POSIXct(x, format="%Y-%m-%d %H:%M:%S %Z", tz=tz, usetz=FALSE)
}

format.Timestamp <- format_default
