# Clock signal
#Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports ClkPort]							
	set_property IOSTANDARD LVCMOS33 [get_ports ClkPort]
	create_clock -add -name ClkPort -period 10.00 [get_ports ClkPort]
 
# Switches
#Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = Sw0
set_property PACKAGE_PIN J15 [get_ports {Sw0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw0}]
#Bank = 34, Pin name = IO_25_34,							Sch name = Sw1
set_property PACKAGE_PIN L16 [get_ports {Sw1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw1}]
#Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = Sw2
set_property PACKAGE_PIN M13 [get_ports {Sw2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw2}]
#Bank = 34, Pin name = IO_L19P_T3_34,						Sch name = Sw3
set_property PACKAGE_PIN R15 [get_ports {Sw3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw3}]
#Bank = 34, Pin name = IO_L19N_T3_VREF_34,					Sch name = Sw4
set_property PACKAGE_PIN R17 [get_ports {Sw4}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw4}]
#Bank = 34, Pin name = IO_L20P_T3_34,						Sch name = Sw5
set_property PACKAGE_PIN T18 [get_ports {Sw5}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw5}]
#Bank = 34, Pin name = IO_L20N_T3_34,						Sch name = Sw6
set_property PACKAGE_PIN U18 [get_ports {Sw6}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw6}]
#Bank = 34, Pin name = IO_L10P_T1_34,						Sch name = Sw7
set_property PACKAGE_PIN R13 [get_ports {Sw7}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw7}]
#Bank = 34, Pin name = IO_L8P_T1-34,						Sch name = Sw8
set_property PACKAGE_PIN T8 [get_ports {Sw8}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Sw8}]
#Bank = 34, Pin name = IO_L9N_T1_DQS_34,					Sch name = Sw9
#set_property PACKAGE_PIN V2 [get_ports {Sw9}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw9}]
#Bank = 34, Pin name = IO_L9P_T1_DQS_34,					Sch name = Sw10
#set_property PACKAGE_PIN U2 [get_ports {Sw10}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw10}]
#Bank = 34, Pin name = IO_L11N_T1_MRCC_34,					Sch name = Sw11
#set_property PACKAGE_PIN T3 [get_ports {Sw11}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw11}]
#Bank = 34, Pin name = IO_L17N_T2_34,						Sch name = Sw12
#set_property PACKAGE_PIN T1 [get_ports {Sw12}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw12}]
#Bank = 34, Pin name = IO_L11P_T1_SRCC_34,					Sch name = Sw13
#set_property PACKAGE_PIN R3 [get_ports {Sw13}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw13}]
#Bank = 34, Pin name = IO_L14N_T2_SRCC_34,					Sch name = Sw14
#set_property PACKAGE_PIN P3 [get_ports {Sw14}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {Sw14}]
#Bank = 34, Pin name = IO_L14P_T2_SRCC_34,					Sch name = Sw15
set_property PACKAGE_PIN V10 [get_ports {Reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Reset}]
 


# LEDs
#Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN H17 [get_ports {Ld0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld0}]
#Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN K15 [get_ports {Ld1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld1}]
#Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN J13 [get_ports {Ld2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld2}]
#Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN N14 [get_ports {Ld3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld3}]
#Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN R18 [get_ports {Ld4}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld4}]
#Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN V17 [get_ports {Ld5}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld5}]
#Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U17 [get_ports {Ld6}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld6}]
#Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U16 [get_ports {Ld7}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld7}]
#Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V16 [get_ports {Ld8}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ld8}]
# #Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
# set_property PACKAGE_PIN T15 [get_ports {Ld9}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld9}]
# #Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
# set_property PACKAGE_PIN V1 [get_ports {Ld10}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld10}]
# #Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
# set_property PACKAGE_PIN R1 [get_ports {Ld11}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld11}]
# #Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
# set_property PACKAGE_PIN P5 [get_ports {Ld12}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld12}]
# #Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
# set_property PACKAGE_PIN U1 [get_ports {Ld13}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld13}]
# #Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
# set_property PACKAGE_PIN R2 [get_ports {Ld14}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld14}]
# #Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
# set_property PACKAGE_PIN P2 [get_ports {Ld15}]					
# 	set_property IOSTANDARD LVCMOS33 [get_ports {Ld15}]

##Bank = 34, Pin name = IO_L5P_T0_34,						Sch name = LED16_R
#set_property PACKAGE_PIN K5 [get_ports RGB1_Red]					
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Red]
##Bank = 15, Pin name = IO_L5P_T0_AD9P_15,					Sch name = LED16_G
#set_property PACKAGE_PIN F13 [get_ports RGB1_Green]				
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Green]
##Bank = 35, Pin name = IO_L19N_T3_VREF_35,					Sch name = LED16_B
#set_property PACKAGE_PIN F6 [get_ports RGB1_Blue]					
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB1_Blue]
##Bank = 34, Pin name = IO_0_34,								Sch name = LED17_R
#set_property PACKAGE_PIN K6 [get_ports RGB2_Red]					
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Red]
##Bank = 35, Pin name = IO_24P_T3_35,						Sch name =  LED17_G
#set_property PACKAGE_PIN H6 [get_ports RGB2_Green]					
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Green]
##Bank = CONFIG, Pin name = IO_L3N_T0_DQS_EMCCLK_14,			Sch name = LED17_B
#set_property PACKAGE_PIN L16 [get_ports RGB2_Blue]					
	#set_property IOSTANDARD LVCMOS33 [get_ports RGB2_Blue]



#7 segment display
#Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = Ca
set_property PACKAGE_PIN T10 [get_ports {Ca}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ca}]
#Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = Cb
set_property PACKAGE_PIN R10 [get_ports {Cb}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cb}]
#Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = Cc
set_property PACKAGE_PIN K16 [get_ports {Cc}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cc}]
#Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = Cd
set_property PACKAGE_PIN K13 [get_ports {Cd}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cd}]
#Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = Ce
set_property PACKAGE_PIN P15 [get_ports {Ce}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Ce}]
#Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = Cf
set_property PACKAGE_PIN T11 [get_ports {Cf}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cf}]
#Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = Cg
set_property PACKAGE_PIN L18 [get_ports {Cg}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Cg}]

#Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = Dp
set_property PACKAGE_PIN H15 [get_ports Dp]							
	set_property IOSTANDARD LVCMOS33 [get_ports Dp]

#Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = An0
set_property PACKAGE_PIN J17 [get_ports {An0}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An0}]
#Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = An1
set_property PACKAGE_PIN J18 [get_ports {An1}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An1}]
#Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = An2
set_property PACKAGE_PIN T9 [get_ports {An2}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An2}]
#Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = An3
set_property PACKAGE_PIN J14 [get_ports {An3}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An3}]
#Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = An4
set_property PACKAGE_PIN P14 [get_ports {An4}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An4}]
#Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = An5
set_property PACKAGE_PIN T14 [get_ports {An5}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An5}]
#Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = An6
set_property PACKAGE_PIN K2 [get_ports {An6}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An6}]
#Bank = 34, Pin name = IO_L1N_T034,							Sch name = An7
set_property PACKAGE_PIN U13 [get_ports {An7}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {An7}]



#Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
#set_property PACKAGE_PIN C12 [get_ports btnCpuReset]				
#	set_property IOSTANDARD LVCMOS33 [get_ports btnCpuReset]
#Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN N17 [get_ports BtnC]						
	set_property IOSTANDARD LVCMOS33 [get_ports BtnC]
#Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN M18 [get_ports BtnU]						
	set_property IOSTANDARD LVCMOS33 [get_ports BtnU]
#Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN P17 [get_ports BtnL]						
	set_property IOSTANDARD LVCMOS33 [get_ports BtnL]
#Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN M17 [get_ports BtnR]						
	set_property IOSTANDARD LVCMOS33 [get_ports BtnR]
#Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN P18 [get_ports BtnD]						
	set_property IOSTANDARD LVCMOS33 [get_ports BtnD]
 
##VGA Connector
##Bank = 35, Pin name = IO_L8N_T1_AD14N_35,					Sch name = VGA_R0
#set_property PACKAGE_PIN A3 [get_ports {vgaRed[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
##Bank = 35, Pin name = IO_L7N_T1_AD6N_35,					Sch name = VGA_R1
#set_property PACKAGE_PIN B4 [get_ports {vgaRed[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
##Bank = 35, Pin name = IO_L1N_T0_AD4N_35,					Sch name = VGA_R2
#set_property PACKAGE_PIN C5 [get_ports {vgaRed[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
##Bank = 35, Pin name = IO_L8P_T1_AD14P_35,					Sch name = VGA_R3
#set_property PACKAGE_PIN A4 [get_ports {vgaRed[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
##Bank = 35, Pin name = IO_L2P_T0_AD12P_35,					Sch name = VGA_B0
#set_property PACKAGE_PIN B7 [get_ports {vgaBlue[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
##Bank = 35, Pin name = IO_L4N_T0_35,						Sch name = VGA_B1
#set_property PACKAGE_PIN C7 [get_ports {vgaBlue[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
##Bank = 35, Pin name = IO_L6N_T0_VREF_35,					Sch name = VGA_B2
#set_property PACKAGE_PIN D7 [get_ports {vgaBlue[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
##Bank = 35, Pin name = IO_L4P_T0_35,						Sch name = VGA_B3
#set_property PACKAGE_PIN D8 [get_ports {vgaBlue[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
##Bank = 35, Pin name = IO_L1P_T0_AD4P_35,					Sch name = VGA_G0
#set_property PACKAGE_PIN C6 [get_ports {vgaGreen[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
##Bank = 35, Pin name = IO_L3N_T0_DQS_AD5N_35,				Sch name = VGA_G1
#set_property PACKAGE_PIN A5 [get_ports {vgaGreen[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
##Bank = 35, Pin name = IO_L2N_T0_AD12N_35,					Sch name = VGA_G2
#set_property PACKAGE_PIN B6 [get_ports {vgaGreen[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
##Bank = 35, Pin name = IO_L3P_T0_DQS_AD5P_35,				Sch name = VGA_G3
#set_property PACKAGE_PIN A6 [get_ports {vgaGreen[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
##Bank = 15, Pin name = IO_L4P_T0_15,						Sch name = VGA_HS
#set_property PACKAGE_PIN B11 [get_ports Hsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
##Bank = 15, Pin name = IO_L3N_T0_DQS_AD1N_15,				Sch name = VGA_VS
#set_property PACKAGE_PIN B12 [get_ports Vsync]						
	#set_property IOSTANDARD LVCMOS33 [get_ports Vsync]

##Quad SPI Flash
##Bank = CONFIG, Pin name = CCLK_0,							Sch name = QSPI_SCK
#set_property PACKAGE_PIN E9 [get_ports {QspiSCK}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiSCK}]
##Bank = CONFIG, Pin name = IO_L1P_T0_D00_MOSI_14,			Sch name = QSPI_DQ0
#set_property PACKAGE_PIN K17 [get_ports {QspiDB[0]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
##Bank = CONFIG, Pin name = IO_L1N_T0_D01_DIN_14,			Sch name = QSPI_DQ1
#set_property PACKAGE_PIN K18 [get_ports {QspiDB[1]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
##Bank = CONFIG, Pin name = IO_L20_T0_D02_14,				Sch name = QSPI_DQ2
#set_property PACKAGE_PIN L14 [get_ports {QspiDB[2]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
##Bank = CONFIG, Pin name = IO_L2P_T0_D03_14,				Sch name = QSPI_DQ3
#set_property PACKAGE_PIN M14 [get_ports {QspiDB[3]}]				
	#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
#Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = QSPI_CSN
set_property PACKAGE_PIN L13 [get_ports QuadSpiFlashCS]					
	set_property IOSTANDARD LVCMOS33 [get_ports QuadSpiFlashCS]