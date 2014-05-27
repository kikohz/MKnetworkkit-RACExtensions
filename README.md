MKnetworkkit-RACExtensions
==========================

Imitation [AFNetworking-RACExtensions](https://github.com/CodaFi/AFNetworking-RACExtensions) achieve MKnetworkkit support RAC 
It builds on, ReactiveCocoa, above AFNetworking, is a more simple, abstract extension 



###Getting Started

    MKNetworkEngine *mkengine = [[MKNetworkEngine alloc] initWithHostName:@"i2.apiary.io"];
    
    [[mkengine rac_GET:@"notes" parameters:nil ssl:NO] subscribeNext:^(MKNetworkOperation *op) {
  
        //
        
    } error:^(NSError *error) {
        //error
    }];
    
    
###License

MKnetworkkit-RACExtensions is available free of change under the Open Source license, along with the MIT license that MKnetworkkit uses. Use it at your own risk.
