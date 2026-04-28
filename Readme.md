# amr_msgs — Custom ROS 2 Interfaces

`amr_msgs` is the shared vocabulary of the OSU-AMR tiered control architecture. It contains all the custom ROS 2 message (`.msg`), service (`.srv`), and action (`.action`) definitions used to communicate between the Central Fleet Manager (CFM), the Overseer, and the physical HOOVER robots.

Since this is a pure interface package, it contains no executable code. All other packages in the workspace (such as `amr_central`, `amr_cfm`, and `amr_roboware`) depend on this package to serialize and deserialize data.

> ⚡ **Dependencies Note:** Because all other packages rely on these definitions, `amr_msgs` must be built **first** before any other package in the workspace.

---

## 🏗️ System Role

```
[amr_cfm] 
    ↓ (CfmTours.msg, CfmEnvironmentUpdate.msg)
[amr_central] 
    ↓ (SimpleControllerCommand.msg, LockTile.srv)
[amr_roboware / Physical AMRs]
    ↓ (Encoder.msg, FirmwareStatus.msg, Heartbeat.msg)
[amr_central Metrics Logger]
```

---

## 📁 Directory Structure

```
amr_msgs/
├── action/              # Long-running task interfaces
├── msg/                 # Standard asynchronous topics
├── srv/                 # Synchronous request/response interfaces
├── CMakeLists.txt       # Interface generation build rules
└── package.xml          # Package dependencies (rosidl_default_generators)
```

---

## 🗂️ Interface Reference

### 📡 Messages (`msg/`)

Used for continuous, asynchronous data streams published to topics.

| Message File | Purpose |
|---|---|
| `CfmTours.msg` | Contains the high-level sequence of destination tags assigned to a specific AMR by the CFM. |
| `CfmEnvironmentUpdate.msg` | Used by the path planner to broadcast updated time and energy cost matrices when a route becomes blocked. |
| `CfmAmrPositionUpdate.msg` | Shares the current position of the AMRs across the network. |
| `Heartbeat.msg` | A simple periodic ping to confirm an AMR is active and connected to the central network. |
| `Encoder.msg` | Raw and filtered wheel velocity data (left/right/forward) published by the chassis. |
| `FirmwareStatus.msg` | Hardware state data, including raw/calibrated battery voltages and system health. |
| `ImuData.msg` | Inertial measurement unit data for orientation and acceleration tracking. |
| `Odom3.msg` | Custom odometry data structure. |
| `KillSwitchReport.msg` | Emergency stop status broadcast. |
| `SimpleControllerCommand.msg` | Low-level driving commands (e.g., follow line, turn, reverse) sent to the robot chassis. |
| `PathStep.msg` | Represents a single step or segment within a calculated path. |

---

### 🔄 Services (`srv/`)

Used for blocking, synchronous calls where a node needs an immediate response before proceeding.

| Service File | Purpose |
|---|---|
| `LockTile.srv` | Critical for collision avoidance. Used by the Task Manager to request or release physical space locks. Contains `tag_name`, `requester`, and `priority`. |
| `PathPlannerReq.srv` | Sent to the Path Planner with a start and end location; returns the computed `route_ids` and instructions. |
| `StateChangeReq.srv` | Requests the robot's hardware state machine to transition to a new operational mode (e.g., executing a command or dancing). |
| `CurrentStateReq.srv` | Queries the physical robot for its current operational state. |
| `LatestRFIDReq.srv` | Queries the most recently scanned RFID tag to confirm physical location. |
| `JunctionHandle.srv` | Logic handling for intersection and junction navigation. |

---

### 🎬 Actions (`action/`)

Used for long-running processes where the requesting node needs continuous feedback.

| Action File | Purpose |
|---|---|
| `CreateCostMatrix.action` | Triggers the background generation of the A* cost matrices and dependency trees. Provides percentage-complete feedback while computing. |
| `AMRAction.action` | General framework for sending complex, multi-step actions to the AMR with progress updates. |

---

## 🚀 How to Build & Modify

If you add or modify an interface in this package, you must rebuild it before building any package that depends on it.

> ⚠️ **IMPORTANT:** If you add a new message, service, or action, you need to update **both** `CMakeLists.txt` and `package.xml`. Just creating the `.msg` file is not enough — the build system must be told to compile it.

```bash
cd ~/AMR
colcon build --packages-select amr_msgs
source install/setup.bash
```

To verify that your custom message compiled correctly and is visible to the ROS 2 environment:

```bash
ros2 interface show amr_msgs/srv/LockTile
```
