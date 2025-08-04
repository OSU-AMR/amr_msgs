# AMR MSGS

The one thing one must remember is not to end a custom serivce type in "Request" when running rmw zenoh. That mistake (really a zenoh bug IMO) has taken a day work to debug...

Other than that, this is a standard ROS custom messages package. If you add a new msg, srv or action type, remember to clean build this repository.