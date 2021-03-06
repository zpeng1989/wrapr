check\_reverse\_dependencies
================

``` r
repos <- c(CRAN="https://cloud.r-project.org")
library("prrd")
td <- tempdir()
package = "wrapr"
packageVersion(package)
```

    ## [1] '2.0.0'

``` r
date()
```

    ## [1] "Sat Feb 22 08:14:01 2020"

``` r
parallelCluster <- NULL
ncores <- parallel::detectCores()
if(ncores > 1) {
  parallelCluster <- parallel::makeCluster(ncores)
}

orig_dir <- getwd()
print(orig_dir)
```

    ## [1] "/Users/johnmount/Documents/work/wrapr/extras"

``` r
setwd(td)
print(td)
```

    ## [1] "/var/folders/7q/h_jp2vj131g5799gfnpzhdp80000gn/T//RtmpzsCnUM"

``` r
options(repos = repos)
jobsdfe <- enqueueJobs(package=package, directory=td)

print("checking:")
```

    ## [1] "checking:"

``` r
print(jobsdfe)
```

    ##   id       title status
    ## 1  1       cdata  READY
    ## 2  2 RcppDynProg  READY
    ## 3  3 rqdatatable  READY
    ## 4  4      rquery  READY
    ## 5  5      seplyr  READY
    ## 6  6        sigr  READY
    ## 7  7      vtreat  READY
    ## 8  8     WVPlots  READY

``` r
mk_fn <- function(package, directory, repos) {
  force(package)
  force(directory)
  force(repos)
  function(i) {
    library("prrd")
    options(repos = repos)
    setwd(directory)
    Sys.sleep(1*i)
    dequeueJobs(package=package, directory=directory)
  }
}
f <- mk_fn(package=package, directory=td, repos=repos)

if(!is.null(parallelCluster)) {
  parallel::parLapply(parallelCluster, seq_len(ncores), f)
} else {
  f(0)
}
```

    ## [[1]]
    ##   id       title  status
    ## 1  2 RcppDynProg WORKING
    ## 2  7      vtreat WORKING
    ## 3  8     WVPlots WORKING
    ## 
    ## [[2]]
    ##   id   title  status
    ## 1  7  vtreat WORKING
    ## 2  8 WVPlots WORKING
    ## 
    ## [[3]]
    ## [1] id     title  status
    ## <0 rows> (or 0-length row.names)
    ## 
    ## [[4]]
    ##   id   title  status
    ## 1  8 WVPlots WORKING

``` r
summariseQueue(package=package, directory=td)
```

    ## Test of wrapr had 8 successes, 0 failures, and 0 skipped packages. 
    ## Ran from 2020-02-22 08:14:08 to 2020-02-22 08:18:04 for 3.933 mins 
    ## Average of 29.5 secs relative to 94.789 secs using 4 runners
    ## 
    ## Failed packages:   
    ## 
    ## Skipped packages:   
    ## 
    ## None still working
    ## 
    ## None still scheduled

``` r
setwd(orig_dir)
if(!is.null(parallelCluster)) {
  parallel::stopCluster(parallelCluster)
}
```
