# FB8981299

In a very large project Xcode can crash while running an app on the simulator (reproducible on Xcode 12.1, 12.2 and 12.3).

The following will be found in the crash log:
```
Failure Reason: The request was denied by service delegate (SBMainWorkspace).

...

Failure Reason: The process failed to launch.
User Info: {
    BSErrorCodeDescription = "launch-failed";
}
```

Inspecting the simulator device logs after the crash shows that `DYLD_FRAMEWORK_PATH` receives all paths to frameworks under the current Built Products folder (which can be a lot), causing this error:

```
{Error Domain=NSPOSIXErrorDomain Code=7 "Argument list too long" ...}
```

The issue can be reproduced using this project by following these steps:

- Open Xcode 12.1 / 12.2 / 12.3 (reproducible on all versions)
- Open 'SampleApp.xcworkspace'
- Select the 'Framework0-App' scheme and pick any simulator
- Build & Run

