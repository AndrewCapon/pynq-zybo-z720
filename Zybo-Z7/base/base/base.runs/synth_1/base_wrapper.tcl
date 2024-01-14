# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "/home/gabriel/Documents/Vivado/base/base.runs/synth_1/base_wrapper.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config  -id {[BD 41-1753]}  -suppress 
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/gabriel/Documents/Vivado/base/base.cache/wt [current_project]
set_property parent.project_path /home/gabriel/Documents/Vivado/base/base.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {/home/gabriel/.Xilinx/Vivado/2022.1/xhub/board_store/xilinx_board_store} [current_project]
set_property board_part digilentinc.com:zybo-z7-20:part0:1.1 [current_project]
set_property ip_repo_paths /home/gabriel/Documents/PYNQ/boards/ip [current_project]
update_ip_catalog
set_property ip_output_repo /home/gabriel/Documents/Vivado/base/base.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_verilog -library xil_defaultlib /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/hdl/base_wrapper.v
add_files /home/gabriel/Documents/Vivado/base/base.srcs/sources_1/bd/base/base.bd
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_xbar_6/base_xbar_6_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_system_interrupts_0/base_system_interrupts_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_system_interrupts_0/base_system_interrupts_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_system_interrupts_0/base_system_interrupts_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_xbar_9/base_xbar_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_vdma_0/base_axi_vdma_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_vdma_0/base_axi_vdma_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_vdma_0/base_axi_vdma_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axis_register_slice_0_0/base_axis_register_slice_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axis_register_slice_0_0/base_axis_register_slice_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_color_convert_0/constraints/color_convert_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_v_vid_in_axi4s_0_0/base_v_vid_in_axi4s_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_v_vid_in_axi4s_0_0/base_v_vid_in_axi4s_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_vtc_in_0/base_vtc_in_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_vtc_in_0/base_vtc_in_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_gpio_hdmiin_0/base_axi_gpio_hdmiin_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_gpio_hdmiin_0/base_axi_gpio_hdmiin_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axi_gpio_hdmiin_0/base_axi_gpio_hdmiin_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_dvi2rgb_0_0/src/dvi2rgb.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_dvi2rgb_0_0/src/dvi2rgb_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_pixel_pack_0/constraints/pixel_pack_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axis_register_slice_0_1/base_axis_register_slice_0_1_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_axis_register_slice_0_1/base_axis_register_slice_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_color_convert_1/constraints/color_convert_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_v_axi4s_vid_out_0_0/base_v_axi4s_vid_out_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_v_axi4s_vid_out_0_0/base_v_axi4s_vid_out_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_vtc_out_0/base_vtc_out_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_vtc_out_0/base_vtc_out_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_hdmi_out_hpd_video_0/base_hdmi_out_hpd_video_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_hdmi_out_hpd_video_0/base_hdmi_out_hpd_video_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_hdmi_out_hpd_video_0/base_hdmi_out_hpd_video_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgb2dvi_0_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgb2dvi_0_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_pixel_unpack_0/constraints/pixel_unpack_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_proc_sys_reset_pixelclk_0/base_proc_sys_reset_pixelclk_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_proc_sys_reset_pixelclk_0/base_proc_sys_reset_pixelclk_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_proc_sys_reset_pixelclk_0/base_proc_sys_reset_pixelclk_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_xbar_10/base_xbar_10_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_btns_gpio_0/base_btns_gpio_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_btns_gpio_0/base_btns_gpio_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_btns_gpio_0/base_btns_gpio_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_leds_gpio_0/base_leds_gpio_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_leds_gpio_0/base_leds_gpio_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_leds_gpio_0/base_leds_gpio_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_ps7_0_0/base_ps7_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgbleds_gpio_0/base_rgbleds_gpio_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgbleds_gpio_0/base_rgbleds_gpio_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rgbleds_gpio_0/base_rgbleds_gpio_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk0_0/base_rst_ps7_0_fclk0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk0_0/base_rst_ps7_0_fclk0_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk0_0/base_rst_ps7_0_fclk0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk1_0/base_rst_ps7_0_fclk1_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk1_0/base_rst_ps7_0_fclk1_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_rst_ps7_0_fclk1_0/base_rst_ps7_0_fclk1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_switches_gpio_0/base_switches_gpio_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_switches_gpio_0/base_switches_gpio_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_switches_gpio_0/base_switches_gpio_0.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_s00_regslice_8/base_s00_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_s00_regslice_8/base_s00_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_6/base_auto_pc_6_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m00_regslice_8/base_m00_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m00_regslice_8/base_m00_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_0/base_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m01_regslice_8/base_m01_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m01_regslice_8/base_m01_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m02_regslice_8/base_m02_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m02_regslice_8/base_m02_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_1/base_auto_pc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m03_regslice_8/base_m03_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m03_regslice_8/base_m03_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_2/base_auto_pc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m04_regslice_8/base_m04_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m04_regslice_8/base_m04_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_3/base_auto_pc_3_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m05_regslice_8/base_m05_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m05_regslice_8/base_m05_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_4/base_auto_pc_4_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m06_regslice_8/base_m06_regslice_8_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m06_regslice_8/base_m06_regslice_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_5/base_auto_pc_5_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_s00_regslice_9/base_s00_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_s00_regslice_9/base_s00_regslice_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_7/base_auto_pc_7_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m00_regslice_9/base_m00_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m00_regslice_9/base_m00_regslice_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m01_regslice_9/base_m01_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m01_regslice_9/base_m01_regslice_9_ooc.xdc]
set_property used_in_synthesis false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_0/base_auto_cc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_0/base_auto_cc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_0/base_auto_cc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m02_regslice_9/base_m02_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m02_regslice_9/base_m02_regslice_9_ooc.xdc]
set_property used_in_synthesis false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_1/base_auto_cc_1_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_1/base_auto_cc_1_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_1/base_auto_cc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m03_regslice_9/base_m03_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m03_regslice_9/base_m03_regslice_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m04_regslice_9/base_m04_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m04_regslice_9/base_m04_regslice_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m05_regslice_9/base_m05_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m05_regslice_9/base_m05_regslice_9_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m06_regslice_9/base_m06_regslice_9_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m06_regslice_9/base_m06_regslice_9_ooc.xdc]
set_property used_in_synthesis false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_2/base_auto_cc_2_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_2/base_auto_cc_2_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_2/base_auto_cc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m07_regslice_0/base_m07_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m07_regslice_0/base_m07_regslice_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_3/base_auto_cc_3_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_3/base_auto_cc_3_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_cc_3/base_auto_cc_3_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m08_regslice_0/base_m08_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m08_regslice_0/base_m08_regslice_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m09_regslice_0/base_m09_regslice_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_m09_regslice_0/base_m09_regslice_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_us_0/base_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_us_0/base_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_us_0/base_auto_us_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/ip/base_auto_pc_8/base_auto_pc_8_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/gabriel/Documents/Vivado/base/base.gen/sources_1/bd/base/base_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/gabriel/Documents/Vivado/base/base.srcs/constrs_1/imports/constraints/base.xdc
set_property used_in_implementation false [get_files /home/gabriel/Documents/Vivado/base/base.srcs/constrs_1/imports/constraints/base.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental /home/gabriel/Documents/PYNQ/boards/Pynq-Z2/base/base/base.srcs/utils_1/imports/synth_1/base_wrapper.dcp
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top base_wrapper -part xc7z020clg400-1
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef base_wrapper.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file base_wrapper_utilization_synth.rpt -pb base_wrapper_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }