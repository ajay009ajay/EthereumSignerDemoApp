#Simple Ethereum Signer App

It is simple ethereum signer demo app which fetch details from Rinkeby network.If you would provide your private key you would ne able to see your ethereum balance.

## Getting Started
Need below environment to setup the project.
XCode: 11.13.1
OS: 10.15.3

### Prerequisites

What things you need to install the software and how to install them

```
You need to setup pod.

platform :ios, '11.0'

target 'EthereumSignerDemoApp' do
  use_modular_headers!

  # Pods for EthereumSignerDemoApp
  pod 'Geth', '~> 1.8.6'
  pod 'BigInt', '~> 3.0'
  pod 'web3swift'
  pod 'QRCodeReader.swift'
  pod 'XCGLogger', '~> 7.0.1'
end

And in terminal please run pod command : pod install
```

### Installing
Once pod is installed, open the project from workspace.

```
EthereumSignerDemoApp.xcworkspace

First screen will ask to give your private key on textfield, easily put it. In next screen you would be seeing your hexadecimal address present on screen.
Fetching of account balance depeneds of block synchronization. If system is already synchronized then balance will reflected immediatly but if it is fresh system it will 2-3 hours to synchronize whole block. You can see the log for more details. Below are similar logs.

=>Block synchronisation started 
=>Stored checkpoint snapshot to disk       number=4110000 hash=1b313c…00a191
=>Imported new block headers               count=384 elapsed=2.136s number=4110384 hash=ca55d7…114e0d age=10mo3w6d
=>Imported new block headers               count=192 elapsed=1.050s number=4110576 hash=30f53e…fd3af8 age=10mo3w6d

10mo3w6d means it is syncing last 10 months 3 weeks and 6 days data.
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

UI test cases are implemented. 


