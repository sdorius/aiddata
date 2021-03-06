AidData for R
-------------

The [AidData](http://aiddata.org) project makes available a wealth of
information on development finance. At the core of their database lies
the project-level information about development aid transfers. The `aiddata`
package for `R` simplifies the access to this database directly from the
`R` console.

To learn more about which donors are included in the database, visit the [AidData
User Guide](http://aiddata.org/user-guide).

Feedback
------------

I'd love to get your feedback / comments / complaints about the package. I'm tracking
all the bugs and recommendations [with GitHub Issues](https://github.com/felixhaass/aiddata/issues), 
so feel free to open a new issue if anything comes to your mind.

Installation
------------

`aiddata` is not (yet) published on CRAN. It needs to be installed
directly from GitHub, using `devtools`:

``` {.r}
install.packages("devtools")
library(devtools)
install_github("felixhaass/aiddata", dependencies = TRUE)
library(aiddata)
```

Overview
--------

`aiddata` is a set of functions that are wrapped around
[`httr`](http://cran.r-project.org/web/packages/httr/) functions to
access and download data from the [AidData
API](http://aiddata.org/use-aiddatas-api).

The main functions are:

-   `get_aid()`: Download project-level information for one or more
    countries in a given time period.
-   `get_gis()`: Download geographic point information for a subset of
    aid projects (not all aid projects are geo-coded)
-   `browse_aid()`: Open browser page with detailed project information
    for a single project.

Examples
--------

### `get_aid()`

`get_aid()` takes as input an ISO-2 character string of recipient or
donor country and start and end years. It downloads information on all
aid projects in the given recipient or from the given donor. If both
recipient and donor are provided, the resulting aid projects represent
information on aid flows in the recipient-donor dyad.

ISO-2 codes for donors and recipient can be obtained with the
[`countrycode`](http://cran.r-project.org/web/packages/countrycode/index.html)
package.

``` {.r}
# Get all aid projects to Angola from 1990 to 1995
result <- get_aid(rec = "AO", start = 1990, end = 1995)

# Get all aid projects to Uganda from Germany in 1990
result <- get_aid(rec = "UG", donor = "DE", start = 1990, end = 1990)
```
Further information about the `get_aid` function is available through
`?get_aid`.

### `get_gis()`

`get_gis()` also takes as input an ISO-2 character string of recipient
or donor country and start and end years. It downloads point information
on the geolocation of aid projects in the given country (or from the
given donor, or both). The function also obtains project information for
these points, using `get_aid`, if the option `proj.info = TRUE`.

Be aware that only a fraction of aid projects is geo-referenced and that the number 
of projects that are geo-referenced vary by country and year.
`get_gis` downloads all aid projects in the given year(s) and countries
and subsets those projects for which point information is available.

``` {.r}
# Get point & project information for aid projects in Kenya from 2010 to 2011
result <- get_gis(rec = "KE", start = 2010, end = 2011, proj.info = TRUE)

# Get point & project information for aid projects in Nepal from from 2006 to 2011 
# (many projects,  so this may take some time)
result <- get_gis(rec = "NP", start = 2006, end = 2011, proj.info = TRUE)
```

The resulting point information can be easily plotted with `R`'s
excellent geo-visualization tools. The following example plots all aid
projects with geo-referenced information in Nepal in 2007. One point represents one 
aid project. Since the
points are partially transparent, the dark red areas represent overlapping points, meaning they
have more aid projects than the light red ones.

``` {.r}
library(raster)
library(ggplot2)
library(aiddata)

result <- get_gis(rec = "NP", start = 2007, end = 2007)

nepal_admin <- getData('GADM', country = "NPL", level = 2)
result_spatial <- SpatialPointsDataFrame(result[, c("lat", "long")], result)

ggplot(fortify(nepal_admin), aes(x = long, y = lat)) + 
  geom_point(data = data.frame(coordinates(result_spatial)), 
             aes(long, lat), alpha = .2, color = "red", size = 2) +
  geom_path(aes(group = group)) +
  ggtitle("Aid Projects in Nepal in 2007\n") + 
  coord_equal() +
  theme_bw() +
  theme(line = element_blank())
```

<img src="https://github.com/felixhaass/aiddata/blob/master/vignettes/figures/unnamed-chunk-4.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />

### `browse_project()`

`browse_project` takes as input the `project_id` given by `get_aid` and
opens a browser window/tab with detailed information on the project from
the [AidData](http://aiddata.org) website. Example:

``` {.r}
# Open browser window for project 800000048457
browse_aid(800000048457)
```


