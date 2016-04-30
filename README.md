# ZoomEye SDK for iOS

ZoomEye SDK written in Swift. (Developing...)

## Features

* Search Host
* Search Web

## Usage

All methods can be used independently, that is ok to invoke ResourceInfo() before Login().

```
import ZoomEye

let zoomeye = ZoomEye("foo@bar.com", "foobar")

// Login
zoomeye.Login {(access_token) in
  print(access_token)
}

// ResourceInfo
zoomeye.ResourceInfo {(resourceInfo) in
  print(resourceInfo)
  print(resourceInfo["plan"])
  print(resourceInfo["resources"])
}

// Search Host
let query_h = "port:21"
let page_h = 1
let facets_h = "app,os"
zoomeye.SearchHost(query_h, page: page_h, facets: facets_h) {
  (host) in
  print(host)
  print(host["ip"])
  print(host["geoinfo"]!["city"])
}

// Search Web
let query_w = "port:21"
let page_w = 1
let facets_w = "webapp,os"
zoomeye.SearchWeb(query_w, page: page_w, facets: facets_w) {
  (web) in
  print(web)
  print(web["site"])
  print(web["server"]!["name"])
}
```
