$LOAD_PATH << File.dirname(__FILE__)+'/../inc'

require 'test/unit'
require 'pp'
require 'HMC/TaskRoles'
require 'HMC/HmcString'

include HmcString

class MyHmcTaskRoles < Test::Unit::TestCase

  def test_TaskRoles

    string = 'name=hmcservicerep,parent=Predefined,"resources=""frame:CheckPSN+DeactivateFrameIO+FrameInitialize+LaunchFrameAsm+ListFrameProperty+ManageFrameServEvents+ManagePSN+RefreshFrame,cec:ActivateSystemProfile+BackupProfileData+CECPowerOff+CECPowerOn+CaptureSystemTemplate+CollectCECVPDInfo+DeployPartitionTemplate+DeviceMaintenance+LSProfileSpace+LaunchAsm+ListCECProperty+ListCoDInformation+ListNPortLogin+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+ManageCECServEvents+ManageDumps+ManageSPP+ManageSysProfile+ManageUtilizationData+RebuildCEC+UpdateLIC+ValidateSystemProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:ActivateLPAR+CapturePartitionTemplate+ChangeNPortLogin+CloseVTerm+Connect5250VTerm+DlparOperation+ListLPARProperty+ListProfileProperty+ManageLPARServEvents+ManageProfile+Open5250VTerm+OpenVTerm+RebootLPAR+ShutdownLPAR+VirtualIOServerCommand,HMCConsole:5250Task+BackupHMCData+ChangeHMCConfiguration+ChangeLocale+ChangeUserPasswords+CollectVPDInfo+CustServiceSettings+FormatMedia+GetUpgradeFiles+GroupingApp+ListConnections+ListHMCConfiguration+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+ManageConsoleDumps+ManageSNMPServiceSettings+ManageServEvents+RepairServEvent+RestoreUpgradeData+SaveUpgradeData+ShutdownHMC+TemplateLibrary+TipOfTheDay+UpdateHMC+UserSettings+ViewConsoleEvents+ViewHMCFileSystems"""
name=hmcviewer,parent=Predefined,"resources=""frame:CheckPSN+ListFrameProperty,cec:CaptureSystemTemplate+CollectCECVPDInfo+LSProfileSpace+ListCECProperty+ListCoDInformation+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+ManageSysProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:CapturePartitionTemplate+ListLPARProperty+ListProfileProperty+ManageProfile,HMCConsole:ChangeLocale+ChangeUserPasswords+CollectVPDInfo+ListConnections+ListHMCConfiguration+ListHMCEncrTask+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+TemplateLibrary+TipOfTheDay+UserSettings+ViewHMCFileSystems"""
name=hmcoperator,parent=Predefined,"resources=""frame:ChangeFrameProperty+CheckPSN+DeactivateFrameIO+FrameInitialize+LaunchFrameAsm+ListFrameProperty+ManageFrameServEvents+ManagePSN+RefreshFrame+RemoveFrameConnection,cec:ActivateSystemProfile+BackupProfileData+CECPowerOff+CECPowerOn+CaptureSystemTemplate+ChangeCECProperty+ChangeSystemProfileProperty+CoDPoolManagement+CollectCECVPDInfo+ConfigProcessorRecovery+CreateLPAR+CreateSystemProfile+DeleteSystemProfile+DeployPartitionTemplate+InitializeProfileData+LSProfileSpace+LaunchAsm+ListCECProperty+ListCoDInformation+ListNPortLogin+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+ManageDumps+ManageSPP+ManageSysProfile+ManageUtilizationData+RebuildCEC+RecoverPartitionData+RemoveCECConnection+RemoveCEConnection+RemoveProfileData+RestoreProfileData+SysProfileCopy+ValidateSystemProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:ActivateLPAR+CapturePartitionTemplate+ChangeLPARProperty+ChangeNPortLogin+ChangeProfileProperty+CloseVTerm+Connect5250VTerm+CreateProfile+DeleteLPAR+DeleteProfile+DlparOperation+HibernateLPAR+ListLPARProperty+ListProfileProperty+ManageLPARServEvents+ManageProfile+MigrateLPAR+Open5250VTerm+OpenVTerm+PartProfileCopy+RebootLPAR+ShutdownLPAR+VirtualIOServerCommand,HMCConsole:5250Task+AddConnection+BackupHMCData+ChangeHMCConfiguration+ChangeHMCFileSystems+ChangeLocale+ChangeUserPasswords+CollectVPDInfo+CreateWelcomeText+CustServiceSettings+FormatMedia+GetUpgradeFiles+GroupingApp+ListConnections+ListHMCConfiguration+ListHMCEncrTask+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+ManageConsoleDumps+ManageSNMPServiceSettings+RestoreUpgradeData+SVAgentXmitServiceInfo+SaveUpgradeData+ScheduleOperations+ShutdownHMC+TemplateLibrary+TipOfTheDay+UserSettings+ViewConsoleEvents+ViewHMCFileSystems+ViewInstallResourceList"""
name=hmcpe,parent=Predefined,"resources=""frame:ChangeFrameProperty+CheckPSN+DeactivateFrameIO+FrameInitialize+LaunchFrameAsm+ListFrameProperty+MakeProfileData+ManageFrameServEvents+ManagePSN+RefreshFrame+RemoveFrameConnection,cec:ActivateSystemProfile+BackupProfileData+CECPowerOff+CECPowerOn+CaptureSystemTemplate+ChangeCECProperty+ChangeSystemProfileProperty+CoDPoolManagement+CollectCECVPDInfo+ConfigHardwareDebugSettings+ConfigProcessorRecovery+CreateLPAR+CreateSystemProfile+DeleteSystemProfile+DeployPartitionTemplate+DeploySystemTemplate+DeviceMaintenance+LSProfileSpace+LaunchAsm+ListCECProperty+ListCoDInformation+ListNPortLogin+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+MakeProfileData+ManageCECServEvents+ManageDumps+ManageSPP+ManageSysProfile+ManageUtilizationData+MoveSriovAdapter+RebuildCEC+RemoveCECConnection+RemoveCEConnection+SysProfileCopy+UpdateLIC+ValidateSystemProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:ActivateLPAR+CapturePartitionTemplate+ChangeLPARProperty+ChangeNPortLogin+ChangeProfileProperty+CloseVTerm+Connect5250VTerm+CreateProfile+DeleteProfile+DlparOperation+HibernateLPAR+ListLPARProperty+ListProfileProperty+ManageLPARServEvents+ManageProfile+MigrateLPAR+Open5250VTerm+OpenVTerm+PartProfileCopy+RebootLPAR+ShutdownLPAR+VirtualIOServerCommand,HMCConsole:5250Task+AddConnection+BackupHMCData+ChangeHMCConfiguration+ChangeHMCFileSystems+ChangeLocale+ChangeUserPasswords+CollectVPDInfo+CustServiceSettings+EditTemplate+FormatMedia+GetUpgradeFiles+GroupingApp+ListConnections+ListHMCConfiguration+ListHMCEncrTask+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+MakeProfileData+ManageConsoleDumps+ManageSNMPServiceSettings+ManageServEvents+RepairServEvent+RestoreUpgradeData+SVAgentXmitServiceInfo+SaveUpgradeData+ShutdownHMC+TemplateLibrary+TipOfTheDay+UpdateHMC+UserSettings+ViewConsoleEvents+ViewHMCFileSystems+ViewHmcInternalLog+ViewInstallResourceList"""
name=hmcsuperadmin,parent=Predefined,"resources=""frame:ChangeFramePassword+ChangeFrameProperty+CheckPSN+DeactivateFrameIO+FrameInitialize+LaunchFrameAsm+ListFrameProperty+ManageFrameServEvents+ManagePSN+RefreshFrame+RemoveFrameConnection+RemoveFrameLock,cec:ActivateSystemProfile+BackupProfileData+CECPowerOff+CECPowerOn+CaptureSystemTemplate+ChangeCECPassword+ChangeCECProperty+ChangeCoD+ChangePowerManagement+ChangeSystemProfileProperty+ChangeVETCode+CoDPoolManagement+CollectCECVPDInfo+ConfigProcessorRecovery+CreateLPAR+CreatePassThruCommand+CreateSystemProfile+DLPARRestoreHWResources+DeleteSystemProfile+DeployPartitionTemplate+DeploySystemPlan+DeploySystemTemplate+DeviceMaintenance+DisconnectOtherHmc+EditCECMTMS+InitializeProfileData+InitializeSPFailover+LSProfileSpace+LaunchAsm+ListCECProperty+ListCoDInformation+ListNPortLogin+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+MakeSystemPlan+ManageCECServEvents+ManageDumps+ManageSPP+ManageSSP+ManageSriovAdapter+ManageSysProfile+ManageUtilizationData+ManageVirtualNetwork+ManageVirtualStorage+MoveSriovAdapter+PartitionConfigurationImage+RebuildCEC+RecoverPartitionData+RemoveCECConnection+RemoveCEConnection+RemoveProfileData+RestoreProfileData+SetCECKeylockPosition+SysProfileCopy+UpdateLIC+ValidateSystemProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:ActivateLPAR+CapturePartitionTemplate+ChangeLPARProperty+ChangeNPortLogin+ChangeProfileProperty+CloseVTerm+Connect5250VTerm+CreateProfile+Delete5250VTerm+DeleteLPAR+DeleteProfile+DlparOperation+HibernateLPAR+ListLPARProperty+ListProfileProperty+ManageLPARServEvents+ManageProfile+MigrateLPAR+Open5250VTerm+OpenVTerm+PartProfileCopy+RebootLPAR+RemoteRestartLPAR+SetLPARKeylockPosition+ShutdownLPAR+VirtualIOServerCommand,HMCConsole:5250Task+AddConnection+BackupHMCData+CertificateManagement+ChangeHMCConfiguration+ChangeHMCEncrTask+ChangeHMCFileSystems+ChangeLocale+ChangeUserPasswords+ChangeUtilizationConfiguration+CollectVPDInfo+ConfigureDataReplication+CreateWelcomeText+CustServiceSettings+EditConsoleMTMS+EditTemplate+ExportData+FormatMedia+GetUpgradeFiles+GroupingApp+GuidedSetupWizard+ListConnections+ListHMCConfiguration+ListHMCEncrTask+ListHMCRole+ListHMCTask+ListHMCUser+ListLdapCfg+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+ListSystemPlan+ManageAllUserPasswords+ManageConsoleDumps+ManageHMCRole+ManageHMCUser+ManageSNMPServiceSettings+ManageServEvents+ManageSystemPlan+RemoteSystemLogSettings+RepairServEvent+RestoreUpgradeData+SVAgentXmitServiceInfo+SaveUpgradeData+ScheduleOperations+ShutdownHMC+TemplateLibrary+TerminateHMCTask+TipOfTheDay+UpdateHMC+UserSettings+ViewConsoleEvents+ViewHMCFileSystems+ViewInstallResourceList+ViewVIOSInstallResourceList"""
'

    hmcTaskRoles = HmcString.parse(string)

#    assert_equal('L2support', myHash['name'], 'name - L2support')
#    assert_equal('L2supportRole', myHash['nameLong'], 'nameLong - L2supportRole')
  end
end




