require 'HMC/HmcString'
require 'pp'

include HmcString


class TaskRole

  attr_reader :name, :parent, :resources_raw
  attr_reader :resources_frame, :resources_cec, :resources_HMCConsole

  def initialize string

    if string.length > 0
      self.parse(string)
    end
  end

  #name=hmcservicerep,parent=Predefined,"resources=""frame:CheckPSN+DeactivateFrameIO+FrameInitialize+LaunchFrameAsm+ListFrameProperty+ManageFrameServEvents+ManagePSN+RefreshFrame,cec:ActivateSystemProfile+BackupProfileData+CECPowerOff+CECPowerOn+CaptureSystemTemplate+CollectCECVPDInfo+DeployPartitionTemplate+DeviceMaintenance+LSProfileSpace+LaunchAsm+ListCECProperty+ListCoDInformation+ListNPortLogin+ListPCIeTopology+ListRioTopology+ListSSP+ListSystemProfileProperty+ListUtilizationData+ListVETInfo+ManageCECServEvents+ManageDumps+ManageSPP+ManageSysProfile+ManageUtilizationData+RebuildCEC+UpdateLIC+ValidateSystemProfile+ViewDumps+ViewPowerManagement+ViewSPP,lpar:ActivateLPAR+CapturePartitionTemplate+ChangeNPortLogin+CloseVTerm+Connect5250VTerm+DlparOperation+ListLPARProperty+ListProfileProperty+ManageLPARServEvents+ManageProfile+Open5250VTerm+OpenVTerm+RebootLPAR+ShutdownLPAR+VirtualIOServerCommand,HMCConsole:5250Task+BackupHMCData+ChangeHMCConfiguration+ChangeLocale+ChangeUserPasswords+CollectVPDInfo+CustServiceSettings+FormatMedia+GetUpgradeFiles+GroupingApp+ListConnections+ListHMCConfiguration+ListSNMPServiceSettings+ListServiceableEvents+ListStorageMedia+ManageConsoleDumps+ManageSNMPServiceSettings+ManageServEvents+RepairServEvent+RestoreUpgradeData+SaveUpgradeData+ShutdownHMC+TemplateLibrary+TipOfTheDay+UpdateHMC+UserSettings+ViewConsoleEvents+ViewHMCFileSystems"""
  def parse(string)

    hash = HmcString.parse(string)

    #pp hash

    @name = hash["name"]
    @parent = hash["parent"]
    @resources_raw = hash['resources']

    parseResorces(@resources_raw)

  end

  def parseResorces(string)


      regexp = /frame:(.*),cec:(.*),HMCConsole:(.*)/
      match = regexp.match(string)
      if (match)
        puts( "frame to:" + match[1])
        resources_frame = match[1].split("+")
        puts( "cec   to:" + match[2])
        puts( "HMCco to:" + match[3])

        pp resources_frame
      else
        puts("can't find regexp")
      end

  end

end