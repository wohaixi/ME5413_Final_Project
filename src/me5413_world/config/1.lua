include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,                -- map_builder.lua的配置信息
  trajectory_builder = TRAJECTORY_BUILDER,  -- trajectory_builder.lua的配置信息
  
  map_frame = "map",                        -- 地图坐标系的名字
  tracking_frame = "imu_link",              -- 将所有传感器数据转换到这个坐标系下
  published_frame = "odom",            -- tf: map -> footprint
  odom_frame = "odom",                      -- 里程计的坐标系名字
  provide_odom_frame = false,               -- 是否提供odom的tf, 如果为true,则tf树为map->odom->footprint
                                            -- 如果为false tf树为map->footprint
  publish_frame_projected_to_2d = false,    -- 是否将坐标系投影到平面上
  --use_pose_extrapolator = false,            -- 发布tf时是使用pose_extrapolator的位姿还是前端计算出来的位姿

  use_odometry = true,                     -- 是否使用里程计,如果使用要求一定要有odom的tf
  use_nav_sat = false,                      -- 是否使用gps
  use_landmarks = false,                    -- 是否使用landmark
  num_laser_scans = 1,                      -- 是否使用单线激光数据
  num_multi_echo_laser_scans = 0,           -- 是否使用multi_echo_laser_scans数据
  num_subdivisions_per_laser_scan = 1,      -- 1帧数据被分成几次处理,一般为1
  num_point_clouds = 0,                     -- 是否使用点云数据
  
  lookup_transform_timeout_sec = 0.5,       -- 查找tf时的超时时间
  submap_publish_period_sec = 0.3,          -- 发布数据的时间间隔
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,

  rangefinder_sampling_ratio = 1.,          -- 传感器数据的采样频率
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true --使用单线激光建立二维地图


TRAJECTORY_BUILDER_2D.use_imu_data = true --是否使用imu数据 true：一定要有imu传感器消息
TRAJECTORY_BUILDER_2D.min_range = 0.1 --激光最小测量距离
TRAJECTORY_BUILDER_2D.max_range = 30 --激光最大测量距离
TRAJECTORY_BUILDER_2D.missing_data_ray_length = 1.
--TRAJECTORY_BUILDER_2D.min_z = 0.2
--TRAJECTORY_BUILDER_2D.max_z = 1.4
--TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.02

--TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 0.5
--TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 200.
--TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_range = 50.

--TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_length = 0.9
--TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.min_num_points = 100
--TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_range = 50.

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true --是否使用相关性匹配
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.translation_delta_cost_weight = 10.
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 1e-1
TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.rotation_delta_cost_weight = 10.

TRAJECTORY_BUILDER_2D.ceres_scan_matcher.occupied_space_weight = 1.
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 1.
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 1.
--TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 0.01

--TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 12

TRAJECTORY_BUILDER_2D.motion_filter.max_distance_meters = 0.01
--TRAJECTORY_BUILDER_2D.motion_filter.max_angle_radians = 0.004
--TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = 1.

TRAJECTORY_BUILDER_2D.submaps.num_range_data = 80.
TRAJECTORY_BUILDER_2D.submaps.grid_options_2d.resolution = 0.1

POSE_GRAPH.optimize_every_n_nodes = 35.
POSE_GRAPH.constraint_builder.sampling_ratio = 0.3
POSE_GRAPH.constraint_builder.max_constraint_distance = 15.
--POSE_GRAPH.constraint_builder.min_score = 0.48
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.65
POSE_GRAPH.optimization_problem.huber_scale = 1e2
--POSE_GRAPH.optimize_every_n_nodes = 35
POSE_GRAPH.constraint_builder.min_score = 0.65
POSE_GRAPH.constraint_builder.ceres_scan_matcher.rotation_weight = 1.

return options
