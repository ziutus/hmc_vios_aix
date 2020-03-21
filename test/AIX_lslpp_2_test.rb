$LOAD_PATH << File.dirname(__FILE__)+'/../lib'
$LOAD_PATH << File.dirname(__FILE__)+'./lib'

require 'AIX/package'
require 'test/unit'
require 'pp'


class AIX_lslpp < Test::Unit::TestCase

  # http://aix-adm.blogspot.com/2014/12/aix-lslpp.html
  def test_lslpp
    string = "DirectorCommonAgent:DirectorCommonAgent:6.3.5.0: : :C: :All required files of Director Common Agent, including JRE, LWI: : : : : : :0:0:/:
DirectorPlatformAgent:DirectorPlatformAgent:6.3.5.0: : :C: :Director Platform Agent for IBM Systems Director on AIX: : : : : : :0:0:/:
ICU4C.rte:ICU4C.rte:6.1.8.15: : :C: :International Components for Unicode : : : : : : :1:0:/:1316
Java5.sdk:Java5.sdk:5.0.0.615: : :C: :Java SDK 32-bit : : : : : : :0:0:/:
Java6.sdk:Java6.sdk:6.0.0.495: : :C: :Java SDK 32-bit : : : : : : :0:0:/:
Tivoli_Management_Agent.client:Tivoli_Management_Agent.client.rte:3.7.1.0: : :C: :Management Framework Endpoint Runtime: : : : : : :1:0:/:
X11.Dt:X11.Dt.ToolTalk:6.1.9.0: : :C: :AIX CDE ToolTalk Support : : : : : : :0:0:/:1341
X11.Dt:X11.Dt.bitmaps:6.1.0.0: : :C: :AIX CDE Bitmaps : : : : : : :0:0:/:0748
X11.Dt:X11.Dt.helpinfo:6.1.2.0: : :C: :AIX CDE Help Files and Volumes : : : : : : :0:0:/:0846
X11.Dt:X11.Dt.helpmin:6.1.2.0: : :C: :AIX CDE Minimum Help Files : : : : : : :0:0:/:0846
X11.Dt:X11.Dt.helprun:6.1.6.0: : :C: :AIX CDE Runtime Help : : : : : : :0:0:/:1042
X11.Dt:X11.Dt.lib:6.1.9.100: : :C: :AIX CDE Runtime Libraries : : : : : : :0:0:/:1543
X11.Dt:X11.Dt.rte:6.1.9.100: : :C: :AIX Common Desktop Environment (CDE) 1.0 : : : : : : :0:0:/:1543
X11.adt:X11.adt.bitmaps:6.1.0.0: : :C: :AIXwindows Application Development Toolkit Bitmap Files : : : : : : :0:0:/:0747
X11.adt:X11.adt.ext:6.1.6.0: : :C: :AIXwindows Application Development Toolkit for X Extensions : : : : : : :0:0:/:1036
X11.adt:X11.adt.imake:6.1.6.0: : :C: :AIXwindows Application Development Toolkit imake : : : : : : :0:0:/:1036
X11.adt:X11.adt.include:6.1.9.100: : :C: :AIXwindows Application Development Toolkit Include Files : : : : : : :0:0:/:1543
X11.adt:X11.adt.lib:6.1.8.0: : :C: :AIXwindows Application Development Toolkit Libraries : : : : : : :0:0:/:1241
X11.adt:X11.adt.motif:6.1.9.0: : :C: :AIXwindows Application Development Toolkit Motif : : : : : : :0:0:/:1341
X11.apps:X11.apps.aixterm:6.1.9.0: : :C: :AIXwindows aixterm Application : : : : : : :0:0:/:1341
X11.apps:X11.apps.clients:6.1.6.0: : :C: :AIXwindows Client Applications : : : : : : :0:0:/:1036
X11.apps:X11.apps.config:6.1.9.0: : :C: :AIXwindows Configuration Applications : : : : : : :0:0:/:1341
X11.apps:X11.apps.custom:6.1.6.0: : :C: :AIXwindows Customizing Tool : : : : : : :0:0:/:1036
X11.apps:X11.apps.msmit:6.1.8.15: : :C: :AIXwindows msmit Application : : : : : : :0:0:/:1316
X11.apps:X11.apps.rte:6.1.9.0: : :C: :AIXwindows Runtime Configuration Applications : : : : : : :0:0:/:1341
X11.apps:X11.apps.util:6.1.6.0: : :C: :AIXwindows Utility Applications : : : : : : :0:0:/:1036
X11.apps:X11.apps.xdm:6.1.9.100: : :C: :AIXwindows xdm Application : : : : : : :0:0:/:1543
X11.apps:X11.apps.xterm:6.1.9.0: : :C: :AIXwindows xterm Application : : : : : : :0:0:/:1341
X11.base:X11.base.common:6.1.8.0: : :C: :AIXwindows Runtime Common Directories : : : : : : :0:0:/:1241
X11.base:X11.base.lib:6.1.9.100: : :C: :AIXwindows Runtime Libraries : : : : : : :0:0:/:1543
X11.base:X11.base.rte:6.1.9.100: : :C: :AIXwindows Runtime Environment : : : : : : :0:0:/:1543
X11.base:X11.base.smt:6.1.8.0: : :C: :AIXwindows Runtime Shared Memory Transport : : : : : : :0:0:/:1241
X11.base:X11.base.xpconfig:6.1.0.0: : :C: :Xprint Configuration Files : : : : : : :0:0:/:0748
X11.compat:X11.compat.adt.Motif12:6.1.0.0: : :C: :AIXwindows Motif 1.2 Compatibility Development Toolkit : : : : : : :0:0:/:0747
X11.compat:X11.compat.lib.Motif10:6.1.1.0: : :C: :AIXwindows Motif 1.0 Libraries Compatibility : : : : : : :0:0:/:0822
X11.compat:X11.compat.lib.Motif114:6.1.0.0: : :C: :AIXwindows Motif 1.1.4 Libraries Compatibility : : : : : : :0:0:/:0747
X11.compat:X11.compat.lib.X11R3:6.1.1.0: : :C: :AIXwindows X11R3 Libraries Compatibility : : : : : : :0:0:/:0822
X11.compat:X11.compat.lib.X11R4:6.1.0.0: : :C: :AIXwindows X11R4 Libraries Compatibility : : : : : : :0:0:/:0747
X11.compat:X11.compat.lib.X11R6:6.1.9.0: : :C: :AIXwindows X11R6 Compatibility Libraries : : : : : : :0:0:/:1341
X11.compat:X11.compat.lib.X11R6_motif:6.1.9.0: : :C: :AIXwindows X11R6 Motif 1.2 & 2.1 Compatibility : : : : : : :0:0:/:1341
X11.fnt:X11.fnt.Gr_Cyr_T1:6.1.0.0: : :C: :AIXwindows Greek-Cyrillic Type1 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.coreX:6.1.0.0: : :C: :AIXwindows X Consortium Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.defaultFonts:6.1.2.0: : :C: :AIXwindows Default Fonts : : : : : : :0:0:/:0846
X11.fnt:X11.fnt.deform_JP:6.1.0.0: : :C: :AIXwindows Japanese PCF Deformed Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.fontServer:6.1.6.0: : :C: :AIXwindows Font Server : : : : : : :0:0:/:1036
X11.fnt:X11.fnt.ibm1046:6.1.0.0: : :C: :AIXwindows Arabic Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.ibm1046_T1:6.1.0.0: : :C: :AIXwindows Arabic Type1 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso1:6.1.0.0: : :C: :AIXwindows Latin 1 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso2:6.1.0.0: : :C: :AIXwindows Latin 2 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso3:6.1.0.0: : :C: :AIXwindows Latin 3 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso4:6.1.0.0: : :C: :AIXwindows Latin 4 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso5:6.1.0.0: : :C: :AIXwindows Cyrillic Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso7:6.1.0.0: : :C: :AIXwindows Greek Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso8:6.1.0.0: : :C: :AIXwindows Hebrew Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso8_T1:6.1.0.0: : :C: :AIXwindows Hebrew Type1 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso9:6.1.0.0: : :C: :AIXwindows Turkish Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.iso_T1:6.1.0.0: : :C: :AIXwindows Latin Type1 Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.ksc5601.ttf:6.1.4.0: : :C: :AIXwindows Korean KSC5601 TrueType Fonts : : : : : : :0:0:/:0943
X11.fnt:X11.fnt.ucs.cjk:6.1.0.0: : :C: :AIXwindows Unicode CJK Fonts : : : : : : :0:0:/:0748
X11.fnt:X11.fnt.ucs.com:6.1.0.0: : :C: :AIXwindows Common Fonts Unicode : : : : : : :0:0:/:0748
X11.fnt.ucs.ttf_CN:X11.fnt.ucs.ttf_CN:6.1.9.100: : :C: :AIXwindows Unicode TrueType Fonts - CJK China : : : : : : :0:0:/:1543
X11.fnt.ucs.ttf_extb:X11.fnt.ucs.ttf_extb:6.1.9.100: : :C: :AIXwindows Unicode TrueType Fonts - Extension B : : : : : : :0:0:/:1543
X11.fnt:X11.fnt.util:6.1.6.0: : :C: :AIXwindows Font Utilities : : : : : : :0:0:/:1036
X11.loc.de_CH:X11.loc.de_CH.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - Swiss German: : : : : : :0:0:/:
X11.loc.de_DE:X11.loc.de_DE.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - German: : : : : : :0:0:/:
X11.loc.en_GB:X11.loc.en_GB.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - U.K. English: : : : : : :0:0:/:
X11.loc.en_US:X11.loc.en_US.Dt.rte:6.1.0.0: : :C: :CDE Locale Configuration - U.S. English: : : : : : :0:0:/:0747
X11.loc.en_US:X11.loc.en_US.base.lib:6.1.0.0: : :C: :AIXwindows Client Locale Config - U.S. English: : : : : : :0:0:/:0747
X11.loc.en_US:X11.loc.en_US.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - U.S. English: : : : : : :0:0:/:0747
X11.loc.fr_BE:X11.loc.fr_BE.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - Belgian French: : : : : : :0:0:/:
X11.loc.fr_CA:X11.loc.fr_CA.base.rte:6.1.2.0: : :C: :AIXwindows Locale Configuration - Canadian French: : : : : : :0:0:/:
X11.loc.fr_FR:X11.loc.fr_FR.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - French: : : : : : :0:0:/:
X11.loc.it_IT:X11.loc.it_IT.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - Italian: : : : : : :0:0:/:
X11.loc.nl_BE:X11.loc.nl_BE.base.rte:6.1.0.0: : :C: :AIXwindows Locale Configuration - Belgian Dutch: : : : : : :0:0:/:
X11.motif:X11.motif.lib:6.1.9.0: : :C: :AIXwindows Motif Libraries : : : : : : :0:0:/:1341
X11.motif:X11.motif.mwm:6.1.7.0: : :C: :AIXwindows Motif Window Manager : : : : : : :0:0:/:1140
X11.samples:X11.samples.apps.clients:6.1.9.0: : :C: :AIXwindows Sample X Consortium Clients Binary/Source : : : : : : :0:0:/:1341
X11.samples:X11.samples.common:6.1.0.0: : :C: :AIXwindows Imakefile Structure for Samples : : : : : : :0:0:/:0747
X11.samples:X11.samples.lib.Core:6.1.8.0: : :C: :AIXwindows Sample X Consortium Core Libraries Binary/Source : : : : : : :0:0:/:1241
X11.vsm:X11.vsm.lib:6.1.8.0: : :C: :Visual System Managment Library : : : : : : :0:0:/:1241
adde.v2.common:adde.v2.common.rte:6.1.9.45: : :C: :ADDE Common Device Runtime Environment : : : : : : :1:0:/:1524
adde.v2.ethernet:adde.v2.ethernet.rte:6.1.9.100: : :C: :ADDE Ethernet Device Runtime Environment : : : : : : :1:0:/:1543
adde.v2.rdma:adde.v2.rdma.rte:6.1.9.100: : :C: :ADDE RDMA Device Runtime Environment : : : : : : :1:0:/:1543
artex.base:artex.base.agent:6.1.9.0: : :C: :AIX Runtime Expert CAS agent : : : : : : :0:0:/:1341
artex.base:artex.base.rte:6.1.9.100: : :C: :AIX Runtime Expert : : : : : : :0:0:/:1543
artex.base:artex.base.samples:6.1.9.100: : :C: :AIX Runtime Expert sample profiles : : : : : : :0:0:/:1543
bos.64bit:bos.64bit:6.1.9.100: : :C: :Base Operating System 64 bit Runtime : : : : : : :1:0:/:1543
bos.acct:bos.acct:6.1.9.100: : :C: :Accounting Services : : : : : : :1:0:/:1543
bos.adt:bos.adt.base:6.1.9.100: : :C: :Base Application Development Toolkit : : : : : : :1:0:/:1543
bos.adt:bos.adt.debug:6.1.9.100: : :C: :Base Application Development Debuggers : : : : : : :1:0:/:1543
bos.adt:bos.adt.graphics:6.1.0.0: : :C: :Base Application Development Graphics Include Files : : : : : : :0:0:/:0748
bos.adt:bos.adt.include:6.1.9.100: : :C: :Base Application Development Include Files : : : : : : :1:0:/:1543
bos.adt:bos.adt.insttools:6.1.9.100: : :C: :Tool to Create installp Packages : : : : : : :0:0:/:1543
bos.adt:bos.adt.lib:6.1.8.0: : :C: :Base Application Development Libraries : : : : : : :1:0:/:1241
bos.adt:bos.adt.libm:6.1.9.15: : :C: :Base Application Development Math Library : : : : : : :1:0:/:1415
bos.adt:bos.adt.libmio:6.1.8.0: : :C: :Modular IO Library : : : : : : :0:0:/:1241
bos.adt:bos.adt.prof:6.1.9.100: : :C: :Base Profiling Support : : : : : : :0:0:/:1543
bos.adt:bos.adt.prt_tools:6.1.3.0: : :C: :Printer Support Development Toolkit : : : : : : :0:0:/:0915
bos.adt:bos.adt.samples:6.1.9.0: : :C: :Base Operating System Samples : : : : : : :0:0:/:1341
bos.adt:bos.adt.sccs:6.1.9.0: : :C: :SCCS Application Development Toolkit : : : : : : :0:0:/:1341
bos.adt:bos.adt.syscalls:6.1.9.100: : :C: :System Calls Application Development Toolkit : : : : : : :0:0:/:1543
bos.adt:bos.adt.utils:6.1.8.0: : :C: :Base Application Development Utilities - lex and yacc : : : : : : :0:0:/:1241
bos.ae:bos.ae:6.1.7.15: : :C: :Activation Engine : : : : : : :1:0:/:1216
bos.ahafs:bos.ahafs:6.1.9.100: : :C: :Aha File System : : : : : : :0:0:/:1543
bos.aixpert.cmds:bos.aixpert.cmds:6.1.9.100: : :C: :AIX Security Hardening : : : : : : :1:0:/:1543
bos.alt_disk_install:bos.alt_disk_install.rte:6.1.9.100: : :C: :Alternate Disk Installation Runtime : : : : : : :0:0:/:1543
bos.aso:bos.aso:6.1.9.100: : :C: :Active System Optimizer : : : : : : :1:0:/:1543
bos.cdmount:bos.cdmount:6.1.6.0: : :C: :CD/DVD Automount Facility : : : : : : :1:0:/:1036
bos.cluster:bos.cluster.rte:6.1.9.100: : :C: :Cluster Aware AIX : : : : : : :0:0:/:1543
bos.compat:bos.compat.links:6.1.9.15: : :C: :AIX 3.2 to 4 Compatibility Links : : : : : : :0:0:/:1415
bos.diag:bos.diag.com:6.1.9.100: : :C: :Common Hardware Diagnostics : : : : : : :1:0:/:1543
bos.diag:bos.diag.rte:6.1.9.100: : :C: :Hardware Diagnostics : : : : : : :1:0:/:1543
bos.diag:bos.diag.util:6.1.9.100: : :C: :Hardware Diagnostics Utilities : : : : : : :1:0:/:1543
bos.ecc_client:bos.ecc_client.rte:6.1.9.100: : :C: :Electronic Customer Care Runtime : : : : : : :0:0:/:1543
bos.esagent:bos.esagent:6.6.9.100: : :C: :Electronic Service Agent : : : : : : :0:0:/:1543
bos.esagent.ivm:bos.esagent.ivm:6.6.9.100: : :C: :Electronic Service Agent for PowerVM : : : : : : :0:0:/:1543
bos.help.msg.en_US:bos.help.msg.en_US.com:6.1.7.15: : :C: :WebSM/SMIT Context Helps - U.S. English : : : : : : :1:0:/:
bos.help.msg.en_US:bos.help.msg.en_US.smit:6.1.9.100: : :C: :SMIT Context Helps - U.S. English: : : : : : :1:0:/:
bos.iconv:bos.iconv.Vi_VN:6.1.0.0: : :C: :ASCII Language Converters - Vietnamese : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.Zh_TW:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - T-Chinese (big5) : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.ar_AA:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Arabic : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.com:6.1.9.100: : :C: :Common Language to Language Converters : : : : : : :1:0:/:1543
bos.iconv:bos.iconv.da_DK:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Danish : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.de_DE:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - German : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.el_GR:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Greek : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.en_GB:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - U.K. English : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.es_ES:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Spanish : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.fr_FR:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - French : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.is_IS:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Icelandic : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.iso2:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Latin 2 Countries : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.iso5:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Cyrillic Countries : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.it_IT:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Italian : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.iw_IL:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Hebrew : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.ja_JP:6.1.9.15: : :C: :EBCDIC & ASCII Language Converters - Japanese : : : : : : :0:0:/:1415
bos.iconv:bos.iconv.ko_KR:6.1.5.0: : :C: :EBCDIC & ASCII Language Converters - Korean : : : : : : :0:0:/:1015
bos.iconv:bos.iconv.tr_TR:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Turkish : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.ucs.ZH_CN:6.1.4.0: : :C: :Unicode Converters for Simplified Chinese : : : : : : :0:0:/:0943
bos.iconv:bos.iconv.ucs.Zh_CN:6.1.4.0: : :C: :Unicode Converters for Simplified Chinese (GB18030) : : : : : : :0:0:/:0943
bos.iconv:bos.iconv.ucs.baltic:6.1.4.0: : :C: :Unicode Converters for Baltic Countries : : : : : : :0:0:/:0943
bos.iconv:bos.iconv.ucs.com:6.1.9.15: : :C: :Unicode Base Converters for AIX Code Sets/Fonts : : : : : : :1:0:/:1415
bos.iconv:bos.iconv.ucs.ebcdic:6.1.9.15: : :C: :Unicode Converters for EBCDIC Code Sets : : : : : : :0:0:/:1415
bos.iconv:bos.iconv.ucs.pc:6.1.9.15: : :C: :Unicode Converters for Additional PC Code Sets : : : : : : :0:0:/:1415
bos.iconv:bos.iconv.zh_CN:6.1.0.0: : :C: :EBCDIC & ASCII Language Converters - Simplified Chinese : : : : : : :0:0:/:0747
bos.iconv:bos.iconv.zh_TW:6.1.5.0: : :C: :EBCDIC & ASCII Language Converters - Traditional Chinese : : : : : : :0:0:/:1015
bos.iocp:bos.iocp.rte:6.1.9.0: : :C: :I/O Completion Ports API : : : : : : :1:0:/:1341
bos.loc.com.AR:bos.loc.com.AR:6.1.0.0: : :C: :Common Locale Support - Arabic: : : : : : :0:0:/:0747
bos.loc.com.CN:bos.loc.com.CN:6.1.6.0: : :C: :Common Locale Support - Simplified Chinese : : : : : : :0:0:/:1036
bos.loc.com.EE:bos.loc.com.EE:6.1.0.0: : :C: :Common Locale Support - Eastern Europe: : : : : : :0:0:/:0747
bos.loc.com.IW:bos.loc.com.IW:6.1.0.0: : :C: :Common Locale Support - Hebrew: : : : : : :0:0:/:0747
bos.loc.com.JP:bos.loc.com.JP:6.1.9.15: : :C: :Common Locale Support - Japanese : : : : : : :0:0:/:1415
bos.loc.com.bidi:bos.loc.com.bidi:6.1.6.15: : :C: :Common Locale Support - Bidirectional Languages : : : : : : :0:0:/:1115
bos.loc.com.utf:bos.loc.com.utf:6.1.8.0: : :C: :Common Locale Support - UTF-8 : : : : : : :0:0:/:1241
bos.loc.iso:bos.loc.iso.Uk_UA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Ukrainian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.Vi_VN:6.1.7.15: : :C: :Base System Locale ISO Code Set - Vietnamese : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.Zh_CN:6.1.7.15: : :C: :Base System Locale ISO Code Set - S-Chinese (GB18030) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.Zh_TW:6.1.7.15: : :C: :Base System Locale ISO Code Set - T-Chinese (big5) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_AA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_AE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (UAE) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_BH:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Bahrain) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_DZ:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Algeria) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_EG:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Egypt) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_JO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Jordan) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_KW:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Kuwait) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_LB:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Lebanon) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_MA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Morocco) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_OM:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Oman) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_QA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Qatar) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_SA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Saudi Arabia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_SY:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Syria) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_TN:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Tunisia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ar_YE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Arabic (Yemen) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.be_BY:6.1.7.15: : :C: :Base System Locale ISO Code Set - Byelorussian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.bg_BG:6.1.7.15: : :C: :Base System Locale ISO Code Set - Bulgarian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ca_ES:6.1.7.15: : :C: :Base System Locale ISO Code Set - Catalan : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.cs_CZ:6.1.7.15: : :C: :Base System Locale ISO Code Set - Czech : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.da_DK:6.1.7.15: : :C: :Base System Locale ISO Code Set - Danish : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.de_AT:6.1.7.15: : :C: :Base System Locale ISO Code Set - German (Austria) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.de_CH:6.1.7.15: : :C: :Base System Locale ISO Code Set - Swiss German : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.de_DE:6.1.7.15: : :C: :Base System Locale ISO Code Set - German : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.de_LU:6.1.7.15: : :C: :Base System Locale ISO Code Set - German (Luxembourg) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.el_GR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Greek : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_AU:6.1.7.15: : :C: :Base System Locale ISO Code Set - Australian English : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_BE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Belgian English : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_CA:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (Canada) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_GB:6.1.7.15: : :C: :Base System Locale ISO Code Set - U.K. English : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_HK:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (Hong Kong) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_IE:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (Ireland) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_IN:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (India) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_NZ:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (New Zealand) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_PH:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (Philippines) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_SG:6.1.7.15: : :C: :Base System Locale ISO Code Set - English (Singapore) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.en_US:6.1.7.15: : :C: :Base System Locale ISO Code Set - U.S. English : : : : : : :1:0:/:1216
bos.loc.iso:bos.loc.iso.en_ZA:6.1.7.15: : :C: :Base System Locale ISO Code Set - South African English : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_AR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Argentina) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_BO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Bolivia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_CL:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Chile) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_CO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Colombia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_CR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Costa Rica) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_DO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (D. Republic) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_EC:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Ecuador) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_ES:6.1.9.0: : :C: :Base System Locale ISO Code Set - Spanish : : : : : : :0:0:/:1341
bos.loc.iso:bos.loc.iso.es_GT:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Guatemala) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_HN:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Honduras) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_MX:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Mexico) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_NI:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Nicaragua) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_PA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Panama) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_PE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Peru) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_PR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Puerto Rico) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_PY:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Paraguay) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_SV:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (El Salvador) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_US:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (United States) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_UY:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Uruguay) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.es_VE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Spanish (Venezuela) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.et_EE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Estonian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fi_FI:6.1.7.15: : :C: :Base System Locale ISO Code Set - Finish : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fr_BE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Belgian French : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fr_CA:6.1.7.15: : :C: :Base System Locale ISO Code Set - Canadian French : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fr_CH:6.1.7.15: : :C: :Base System Locale ISO Code Set - Swiss French : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fr_FR:6.1.7.15: : :C: :Base System Locale ISO Code Set - French : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.fr_LU:6.1.7.15: : :C: :Base System Locale ISO Code Set - French (Luxembourg) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.hr_HR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Croatian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.hu_HU:6.1.7.15: : :C: :Base System Locale ISO Code Set - Hungarian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.id_ID:6.1.7.15: : :C: :Base System Locale ISO Code Set - Indonesian (Indonesia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.is_IS:6.1.7.15: : :C: :Base System Locale ISO Code Set - Icelandic : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.it_CH:6.1.7.15: : :C: :Base System Locale ISO Code Set - Swiss Italian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.it_IT:6.1.7.15: : :C: :Base System Locale ISO Code Set - Italian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.iw_IL:6.1.7.15: : :C: :Base System Locale ISO Code Set - Hebrew : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ja_JP:6.1.9.15: : :C: :Base System Locale ISO Code Set - Japanese : : : : : : :0:0:/:1415
bos.loc.iso:bos.loc.iso.ko_KR:6.1.8.0: : :C: :Base System Locale ISO Code Set - Korean : : : : : : :0:0:/:1241
bos.loc.iso:bos.loc.iso.lt_LT:6.1.7.15: : :C: :Base System Locale ISO Code Set - Lithuanian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.lv_LV:6.1.7.15: : :C: :Base System Locale ISO Code Set - Latvian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.mk_MK:6.1.7.15: : :C: :Base System Locale ISO Code Set - Macedonian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ms_MY:6.1.7.15: : :C: :Base System Locale ISO Code Set - Malay (Malaysia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.nl_BE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Belgian Dutch : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.nl_NL:6.1.7.15: : :C: :Base System Locale ISO Code Set - Netherlands Dutch : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.no_NO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Norwegian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.pl_PL:6.1.7.15: : :C: :Base System Locale ISO Code Set - Polish : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.pt_BR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Portuguese (Brazil) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.pt_PT:6.1.7.15: : :C: :Base System Locale ISO Code Set - Portuguese : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ro_RO:6.1.7.15: : :C: :Base System Locale ISO Code Set - Romanian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.ru_RU:6.1.7.15: : :C: :Base System Locale ISO Code Set - Russian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sh_SP:6.1.7.15: : :C: :Base System Locale ISO Code Set - Serbian Latin : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sh_YU:6.1.7.15: : :C: :Base System Locale ISO Code Set - Serbian Latin (Yugoslavia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sk_SK:6.1.7.15: : :C: :Base System Locale ISO Code Set - Slovak : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sl_SI:6.1.7.15: : :C: :Base System Locale ISO Code Set - Slovene : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sq_AL:6.1.7.15: : :C: :Base System Locale ISO Code Set - Albanian : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sr_SP:6.1.7.15: : :C: :Base System Locale ISO Code Set - Serbian Cyrillic : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sr_YU:6.1.7.15: : :C: :Base System Locale ISO Code Set - S. Cyr. (Yugoslavia) : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.sv_SE:6.1.7.15: : :C: :Base System Locale ISO Code Set - Swedish : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.th_TH:6.1.7.15: : :C: :Base System Locale ISO Code Set - Thai : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.tr_TR:6.1.7.15: : :C: :Base System Locale ISO Code Set - Turkish : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.zh_CN:6.1.7.15: : :C: :Base System Locale ISO Code Set - Simplified Chinese : : : : : : :0:0:/:1216
bos.loc.iso:bos.loc.iso.zh_TW:6.1.9.0: : :C: :Base System Locale ISO Code Set - Traditional Chinese : : : : : : :0:0:/:1341
bos.loc.pc:bos.loc.pc.Ja_JP:6.1.9.15: : :C: :Base System Locale PC Code Set - Japanese : : : : : : :0:0:/:1415
bos.loc.utf.EN_US:bos.loc.utf.EN_US:6.1.7.15: : :C: :Base System Locale UTF Code Set - U. S. English : : : : : : :0:0:/:1216
bos.loc.utf.ZH_CN:bos.loc.utf.ZH_CN:6.1.7.15: : :C: :Base System Locale UTF Code Set - Simplified Chinese : : : : : : :0:0:/:1216
bos.loc.utf.ZH_TW:bos.loc.utf.ZH_TW:6.1.7.15: : :C: :Base System Locale UTF Code Set - Traditional Chinese : : : : : : :0:0:/:1216
bos.mh:bos.mh:6.1.9.0: : :C: :Mail Handler : : : : : : :1:0:/:1341
bos.mls:bos.mls.lib:6.1.0.0: : :C: :Trusted AIX Libraries : : : : : : :1:0:/:0748
bos.mp64:bos.mp64:6.1.9.100: : :C: :Base Operating System 64-bit Multiprocessor Runtime : : : : : : :1:0:/:1543
bos.msg.ca_ES:bos.msg.ca_ES.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - Catalan: : : : : : :0:0:/:
bos.msg.ca_ES:bos.msg.ca_ES.rte:6.1.9.0: : :C: :Base OS Runtime Messages - Catalan: : : : : : :0:0:/:
bos.msg.de_DE:bos.msg.de_DE.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - German: : : : : : :0:0:/:
bos.msg.de_DE:bos.msg.de_DE.rte:6.1.9.0: : :C: :Base OS Runtime Messages - German: : : : : : :0:0:/:
bos.msg.en_US:bos.msg.en_US.diag.rte:6.1.4.0: : :C: :Hardware Diagnostics Messages - U.S. English : : : : : : :1:0:/:0943
bos.msg.en_US:bos.msg.en_US.net.ipsec:6.1.4.0: : :C: :IP Security Messages - U.S. English : : : : : : :1:0:/:0943
bos.msg.en_US:bos.msg.en_US.net.tcp.client:6.1.4.0: : :C: :TCP/IP Messages - U.S. English : : : : : : :1:0:/:0943
bos.msg.en_US:bos.msg.en_US.rte:6.1.7.0: : :C: :Base OS Runtime Messages - U.S. English : : : : : : :1:0:/:1140
bos.msg.en_US:bos.msg.en_US.txt.tfs:6.1.4.0: : :C: :Text Formatting Services Msgs - U.S. English : : : : : : :1:0:/:0943
bos.msg.es_ES:bos.msg.es_ES.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - Spanish: : : : : : :0:0:/:
bos.msg.es_ES:bos.msg.es_ES.rte:6.1.9.0: : :C: :Base OS Runtime Messages - Spanish: : : : : : :0:0:/:
bos.msg.fr_FR:bos.msg.fr_FR.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - French: : : : : : :0:0:/:
bos.msg.fr_FR:bos.msg.fr_FR.rte:6.1.9.0: : :C: :Base OS Runtime Messages - French: : : : : : :0:0:/:
bos.msg.it_IT:bos.msg.it_IT.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - Italian: : : : : : :0:0:/:
bos.msg.it_IT:bos.msg.it_IT.rte:6.1.9.0: : :C: :Base OS Runtime Messages - Italian: : : : : : :0:0:/:
bos.msg.pt_BR:bos.msg.pt_BR.net.tcp.client:6.1.9.0: : :C: :TCP/IP Messages - Brazilian Portuguese: : : : : : :0:0:/:
bos.msg.pt_BR:bos.msg.pt_BR.rte:6.1.9.0: : :C: :Base OS Runtime Messages - Brazilian Portuguese: : : : : : :0:0:/:
bos.net:bos.net.ate:6.1.6.0: : :C: :Asynchronous Terminal Emulator : : : : : : :0:0:/:1036
bos.net:bos.net.ewlm.rte:6.1.8.0: : :C: :netWLM : : : : : : :0:0:/:1241
bos.net:bos.net.ipsec.keymgt:6.1.9.100: : :C: :IP Security Key Management : : : : : : :1:0:/:1543
bos.net:bos.net.ipsec.rte:6.1.9.100: : :C: :IP Security : : : : : : :1:0:/:1543
bos.net:bos.net.ipsec.websm:6.1.9.100: : :C: :IP Security WebSM : : : : : : :0:0:/:1543
bos.net:bos.net.mobip6.rte:6.1.8.0: : :C: :IPv6 Mobility : : : : : : :0:0:/:1241
bos.net:bos.net.ncs:6.1.8.15: : :C: :Network Computing System 1.5.1 : : : : : : :1:0:/:1316
bos.net:bos.net.nfs.adt:6.1.9.100: : :C: :Network File System Development Toolkit : : : : : : :0:0:/:1543
bos.net:bos.net.nfs.cachefs:6.1.9.100: : :C: :CacheFS File System : : : : : : :0:0:/:1543
bos.net:bos.net.nfs.client:6.1.9.100: : :C: :Network File System Client : : : : : : :1:0:/:1543
bos.net:bos.net.nfs.server:6.1.9.100: : :C: :Network File System Server : : : : : : :0:0:/:1543
bos.net:bos.net.nis.client:6.1.9.100: : :C: :Network Information Service Client : : : : : : :1:0:/:1543
bos.net:bos.net.nis.server:6.1.9.100: : :C: :Network Information Service Server : : : : : : :0:0:/:1543
bos.net:bos.net.nisplus:6.1.9.100: : :C: :Network Information Services Plus (NIS+) : : : : : : :0:0:/:1543
bos.net:bos.net.ppp:6.1.8.0: : :C: :Async Point to Point Protocol : : : : : : :0:0:/:1241
bos.net:bos.net.sctp:6.1.9.100: : :C: :Stream Control Transmission Protocol : : : : : : :0:0:/:1543
bos.net:bos.net.snapp:6.1.8.15: : :C: :System Networking Analysis and Performance Pilot : : : : : : :1:0:/:1316
bos.net:bos.net.tcp.adt:6.1.9.100: : :C: :TCP/IP Application Toolkit : : : : : : :1:0:/:1543
bos.net:bos.net.tcp.client:6.1.9.101: : :C: :TCP/IP Client Support : : : : : : :1:0:/:1543
bos.net:bos.net.tcp.server:6.1.9.100: : :C: :TCP/IP Server : : : : : : :1:0:/:1543
bos.net:bos.net.tcp.smit:6.1.9.100: : :C: :TCP/IP SMIT Support : : : : : : :1:0:/:1543
bos.net:bos.net.uucp:6.1.9.0: : :C: :Unix to Unix Copy Program : : : : : : :1:0:/:1341
bos.perf:bos.perf.diag_tool:6.1.8.15: : :C: :Performance Diagnostic Tool : : : : : : :1:0:/:1316
bos.perf.fdpr:bos.perf.fdpr:6.1.8.15: : :C: :Feedback Directed Program Restructuring performance tool : : : : : : :0:0:/:1316
bos.perf:bos.perf.libperfstat:6.1.9.100: : :C: :Performance Statistics Library Interface : : : : : : :1:0:/:1543
bos.perf:bos.perf.perfstat:6.1.9.100: : :C: :Performance Statistics Interface : : : : : : :1:0:/:1543
bos.perf.pmaix:bos.perf.pmaix:6.1.9.100: : :C: :Performance Management : : : : : : :1:0:/:1543
bos.perf:bos.perf.proctools:6.1.9.100: : :C: :Proc Filesystem Tools : : : : : : :1:0:/:1543
bos.perf:bos.perf.tools:6.1.9.100: : :C: :Base Performance Tools : : : : : : :1:0:/:1543
bos.perf:bos.perf.tune:6.1.9.100: : :C: :Performance Tuning Support : : : : : : :1:0:/:1543
bos.pmapi:bos.pmapi.events:6.1.9.15: : :C: :Performance Monitor API Event Codes : : : : : : :1:0:/:1415
bos.pmapi:bos.pmapi.lib:6.1.9.100: : :C: :Performance Monitor API Library : : : : : : :1:0:/:1543
bos.pmapi:bos.pmapi.pmsvcs:6.1.9.100: : :C: :Performance Monitor API Kernel Extension : : : : : : :1:0:/:1543
bos.pmapi:bos.pmapi.samples:6.1.9.100: : :C: :Performance Monitor API Samples : : : : : : :1:0:/:1543
bos.pmapi:bos.pmapi.tools:6.1.9.100: : :C: :Performance Monitor API Tools : : : : : : :1:0:/:1543
bos:bos.rte:6.1.9.100: : :C: :Base Operating System Runtime: : : : : : :1:0:/:
bos:bos.rte.Dt:6.1.2.0: : :C: :Desktop Integrator: : : : : : :1:0:/:
bos:bos.rte.ILS:6.1.8.0: : :C: :International Language Support: : : : : : :1:0:/:
bos:bos.rte.SRC:6.1.9.100: : :C: :System Resource Controller: : : : : : :1:0:/:
bos:bos.rte.X11:6.1.0.0: : :C: :AIXwindows Device Support: : : : : : :1:0:/:
bos:bos.rte.aio:6.1.9.100: : :C: :Asynchronous I/O Extension: : : : : : :1:0:/:
bos:bos.rte.archive:6.1.9.100: : :C: :Archive Commands: : : : : : :1:0:/:
bos:bos.rte.bind_cmds:6.1.9.100: : :C: :Binder and Loader Commands: : : : : : :1:0:/:
bos:bos.rte.boot:6.1.9.100: : :C: :Boot Commands: : : : : : :1:0:/:
bos:bos.rte.bosinst:6.1.9.100: : :C: :Base OS Install Commands: : : : : : :1:0:/:
bos:bos.rte.commands:6.1.9.100: : :C: :Commands: : : : : : :1:0:/:
bos:bos.rte.compare:6.1.6.0: : :C: :File Compare Commands: : : : : : :1:0:/:
bos:bos.rte.console:6.1.6.15: : :C: :Console: : : : : : :1:0:/:
bos:bos.rte.control:6.1.9.100: : :C: :System Control Commands: : : : : : :1:0:/:
bos:bos.rte.cron:6.1.9.100: : :C: :Batch Operations: : : : : : :1:0:/:
bos:bos.rte.date:6.1.9.100: : :C: :Date Control Commands: : : : : : :1:0:/:
bos:bos.rte.devices:6.1.9.100: : :C: :Base Device Drivers: : : : : : :1:0:/:
bos:bos.rte.devices_msg:6.1.9.100: : :C: :Device Driver Messages: : : : : : :1:0:/:
bos:bos.rte.diag:6.1.9.100: : :C: :Diagnostics: : : : : : :1:0:/:
bos:bos.rte.edit:6.1.9.100: : :C: :Editors: : : : : : :1:0:/:
bos:bos.rte.filesystem:6.1.9.100: : :C: :Filesystem Administration: : : : : : :1:0:/:
bos:bos.rte.iconv:6.1.9.15: : :C: :Language Converters: : : : : : :1:0:/:
bos:bos.rte.ifor_ls:6.1.8.0: : :C: :iFOR/LS Libraries: : : : : : :1:0:/:
bos:bos.rte.im:6.1.6.0: : :C: :Input Methods: : : : : : :1:0:/:
bos:bos.rte.install:6.1.9.100: : :C: :LPP Install Commands: : : : : : :1:0:/:
bos:bos.rte.jfscomp:6.1.9.100: : :C: :JFS Compression: : : : : : :1:0:/:
bos:bos.rte.libc:6.1.9.100: : :C: :libc Library: : : : : : :1:0:/:
bos:bos.rte.libcfg:6.1.9.0: : :C: :libcfg Library: : : : : : :1:0:/:
bos:bos.rte.libcur:6.1.9.15: : :C: :libcurses Library: : : : : : :1:0:/:
bos:bos.rte.libdbm:6.1.6.0: : :C: :libdbm Library: : : : : : :1:0:/:
bos:bos.rte.libnetsvc:6.1.0.0: : :C: :Network Services Libraries: : : : : : :1:0:/:
bos:bos.rte.libpthreads:6.1.9.100: : :C: :pthreads Library: : : : : : :1:0:/:
bos:bos.rte.libqb:6.1.6.0: : :C: :libqb Library: : : : : : :1:0:/:
bos:bos.rte.libs:6.1.0.0: : :C: :libs Library: : : : : : :1:0:/:
bos:bos.rte.loc:6.1.8.0: : :C: :Base Locale Support: : : : : : :1:0:/:
bos:bos.rte.lvm:6.1.9.100: : :C: :Logical Volume Manager: : : : : : :1:0:/:
bos:bos.rte.man:6.1.9.100: : :C: :Man Commands: : : : : : :1:0:/:
bos:bos.rte.methods:6.1.9.100: : :C: :Device Config Methods: : : : : : :1:0:/:
bos:bos.rte.misc_cmds:6.1.9.100: : :C: :Miscellaneous Commands: : : : : : :1:0:/:
bos:bos.rte.mlslib:6.1.8.0: : :C: :Trusted AIX Libraries: : : : : : :1:0:/:
bos:bos.rte.net:6.1.9.100: : :C: :Network: : : : : : :1:0:/:
bos:bos.rte.odm:6.1.9.100: : :C: :Object Data Manager: : : : : : :1:0:/:
bos:bos.rte.printers:6.1.9.100: : :C: :Front End Printer Support: : : : : : :1:0:/:
bos:bos.rte.security:6.1.9.100: : :C: :Base Security Function: : : : : : :1:0:/:
bos:bos.rte.serv_aid:6.1.9.100: : :C: :Error Log Service Aids: : : : : : :1:0:/:
bos:bos.rte.shell:6.1.9.100: : :C: :Shells (bsh, ksh, csh): : : : : : :1:0:/:
bos:bos.rte.streams:6.1.8.0: : :C: :Streams Libraries: : : : : : :1:0:/:
bos:bos.rte.tty:6.1.9.100: : :C: :Base TTY Support and Commands: : : : : : :1:0:/:
bos.suma:bos.suma:6.1.9.100: : :C: :Service Update Management Assistant (SUMA) : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.dir_enabled:6.1.9.100: : :C: :System V Directory-enabled Commands : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.fonts:6.1.9.100: : :C: :System V Print Fonts : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.hpnp:6.1.9.100: : :C: :System V Hewlett-Packard JetDirect : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.ps:6.1.9.100: : :C: :System V Print Postscript : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.rte:6.1.9.100: : :C: :System V Print Subsystem : : : : : : :0:0:/:1543
bos.svprint:bos.svprint.trans:6.1.9.100: : :C: :System V Print Translation : : : : : : :0:0:/:1543
bos.swma:bos.swma:6.1.8.15: : :C: :Software Maintenance Agreement : : : : : : :1:0:/:1316
bos.sysmgt:bos.sysmgt.loginlic:6.1.9.0: : :C: :License Management : : : : : : :1:0:/:1341
bos.sysmgt:bos.sysmgt.nim.client:6.1.9.100: : :C: :Network Install Manager - Client Tools : : : : : : :1:0:/:1543
bos.sysmgt:bos.sysmgt.quota:6.1.9.100: : :C: :Filesystem Quota Commands : : : : : : :1:0:/:1543
bos.sysmgt:bos.sysmgt.serv_aid:6.1.9.100: : :C: :Software Error Logging and Dump Service Aids : : : : : : :1:0:/:1543
bos.sysmgt:bos.sysmgt.smit:6.1.9.15: : :C: :System Management Interface Tool (SMIT) : : : : : : :1:0:/:1415
bos.sysmgt:bos.sysmgt.sysbr:6.1.9.100: : :C: :System Backup and BOS Install Utilities : : : : : : :1:0:/:1543
bos.sysmgt:bos.sysmgt.trace:6.1.9.100: : :C: :Software Trace Service Aids : : : : : : :1:0:/:1543
bos.terminfo:bos.terminfo.adds.data:6.1.0.0: : :C: :ADDS Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.annarbor.data:6.1.0.0: : :C: :Annarbor Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.ansi.data:6.1.0.0: : :C: :Amer National Stds Institute Terminal Defs : : : : : : :1:0:/:0747
bos.terminfo:bos.terminfo.att.data:6.1.0.0: : :C: :AT&T Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.beehive.data:6.1.0.0: : :C: :Beehive Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.bull.data:6.1.0.0: : :C: :Bull Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.cdc.data:6.1.0.0: : :C: :Control Data Corp. Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.colorscan.data:6.1.0.0: : :C: :Datamedia Colorscan Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.com.data:6.1.0.0: : :C: :Common Terminal Definitions : : : : : : :1:0:/:0747
bos.terminfo:bos.terminfo.datamedia.data:6.1.0.0: : :C: :Datamedia Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.dec.data:6.1.1.0: : :C: :Digital Equipment Corp. Terminal Definitions : : : : : : :1:0:/:0822
bos.terminfo:bos.terminfo.diablo.data:6.1.0.0: : :C: :Generic Daisy Wheel Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.falco.data:6.1.0.0: : :C: :Falco Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.fortune.data:6.1.0.0: : :C: :Fortune Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.general.data:6.1.0.0: : :C: :General Terminal Corp. Term Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.hardcopy.data:6.1.0.0: : :C: :Hard Copy Terminals Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.hazeltine.data:6.1.0.0: : :C: :Hazeltine Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.hds.data:6.1.0.0: : :C: :Human Designed Systems Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.heath.data:6.1.0.0: : :C: :Heathkit and Zenith Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.homebrew.data:6.1.0.0: : :C: :Home-made Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.hp.data:6.1.0.0: : :C: :Hewlett-Packard Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.ibm.data:6.1.0.0: : :C: :IBM Terminal Definitions : : : : : : :1:0:/:0747
bos.terminfo:bos.terminfo.lsi.data:6.1.0.0: : :C: :Lear Siegler Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.microterm.data:6.1.0.0: : :C: :Microterm Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.misc.data:6.1.0.0: : :C: :Miscellaneous Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.pc.data:6.1.4.0: : :C: :Personal Computer Terminal Definitions : : : : : : :1:0:/:0943
bos.terminfo:bos.terminfo.pci.data:6.1.0.0: : :C: :DOS Server Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.perkinelmer.data:6.1.0.0: : :C: :Perkin Elmer Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.pmcons.data:6.1.0.0: : :C: :PMAX Console Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.print.data:6.1.0.0: : :C: :Generic Line Printer Terminal Definitions : : : : : : :1:0:/:0747
bos.terminfo:bos.terminfo.rte:6.1.6.0: : :C: :Run-time Environment for AIX Terminals : : : : : : :1:0:/:1036
bos.terminfo:bos.terminfo.special.data:6.1.0.0: : :C: :Special Generic Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.sperry.data:6.1.0.0: : :C: :Sperry Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.svprint.data:6.1.2.0: : :C: :System V Printer Terminal Definitions : : : : : : :0:0:/:0846
bos.terminfo:bos.terminfo.tektronix.data:6.1.0.0: : :C: :Tektronix Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.teleray.data:6.1.0.0: : :C: :Teleray Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.televideo.data:6.1.0.0: : :C: :Televideo Terminal Definitions : : : : : : :1:0:/:0747
bos.terminfo:bos.terminfo.ti.data:6.1.0.0: : :C: :Texas Instruments Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.tymshare.data:6.1.0.0: : :C: :Tymshare Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.visual.data:6.1.0.0: : :C: :Visual Terminal Definitions : : : : : : :0:0:/:0747
bos.terminfo:bos.terminfo.wyse.data:6.1.0.0: : :C: :Wyse Terminal Definitions : : : : : : :1:0:/:0747
bos.txt:bos.txt.spell:6.1.6.0: : :C: :Writer's Tools Commands : : : : : : :1:0:/:1036
bos.txt:bos.txt.spell.data:6.1.0.0: : :C: :Writer's Tools Data : : : : : : :1:0:/:0747
bos.txt:bos.txt.tfs:6.1.9.100: : :C: :Text Formatting Services Commands : : : : : : :1:0:/:1543
bos.txt:bos.txt.tfs.data:6.1.0.0: : :C: :Text Formatting Services Data : : : : : : :1:0:/:0747
bos.wpars:bos.wpars:6.1.9.100: : :C: :AIX Workload Partitions : : : : : : :1:0:/:1543
cache.mgt:cache.mgt.rte:6.1.9.100: : :C: :AIX SSD Cache Device Management : : : : : : :0:0:/:1543
cas.agent:cas.agent:1.4.2.600: : :C: :Common Agent Services Agent: : : : : : :0:0:/:
chef:chef:12.8.1.1: : :C: :The full stack of chef: : : : : : :0:0:/:
clic.rte:clic.rte.kernext:4.10.0.1: : :C: :CryptoLite for C Kernel: : : : : : :1:0:/:
clic.rte:clic.rte.lib:4.10.0.1: : :C: :CryptoLite for C Library: : : : : : :1:0:/:
csm.client:csm.client:1.7.1.7: : :C:F:Cluster Systems Management Client: : : : : : :1:0:/:
csm.core:csm.core:1.7.1.6: : :C:F:Cluster Systems Management Core: : : : : : :1:0:/:
csm.deploy:csm.deploy:1.7.1.3: : :C:F:Cluster Systems Management Deployment Component: : : : : : :1:0:/:
csm.diagnostics:csm.diagnostics:1.7.1.0: : :C: :Cluster Systems Management Probe Manager / Diagnostics: : : : : : :1:0:/:
csm.dsh:csm.dsh:1.7.1.5: : :C:F:Cluster Systems Management Dsh: : : : : : :1:0:/:
csm.ivm.client:csm.ivm.client:1.7.1.0: : :C: :Cluster Systems Management IVM Client: : : : : : :0:0:/:
csm.ivm.server:csm.ivm.server:1.7.1.0: : :C: :Cluster Systems Management IVM Server: : : : : : :0:0:/:
csm.msg.EN_US:csm.msg.EN_US.core:1.7.0.0: : :C: :CSM Core Func Msgs - U.S. English (UTF): : : : : : :1:0:/:
csm.msg.en_US:csm.msg.en_US.core:1.7.0.0: : :C: :CSM Core Func Msgs - U.S. English: : : : : : :1:0:/:
devices.artic960:devices.artic960.diag:6.1.6.0: : :C: :IBM ARTIC960 Adapter Diagnostics : : : : : : :1:0:/:1036
devices.artic960:devices.artic960.rte:6.1.8.0: : :C: :IBM ARTIC960 Runtime Support : : : : : : :1:0:/:1241
devices.artic960:devices.artic960.ucode:6.1.0.0: : :C: :IBM ARTIC960 Adapter Software : : : : : : :1:0:/:0747
devices.chrp.AT97SC3201_r:devices.chrp.AT97SC3201_r.rte:6.1.0.0: : :C: :Trusted Platform Module Device Software: : : : : : :1:0:/:0747
devices.chrp.IBM.HPS:devices.chrp.IBM.HPS.hpsfu:1.4.2.0: : :C: :IBM pSeries HPS Functional Utility: : : : : : :1:0:/:
devices.chrp.IBM.HPS:devices.chrp.IBM.HPS.rte:1.4.2.0: : :C: :IBM eServer pSeries High Performance Switch (HPS) Runtime: : : : : : :1:0:/:
devices.chrp.IBM.lhca:devices.chrp.IBM.lhca.rte:6.1.9.100: : :C: :Infiniband Logical HCA Runtime Environment : : : : : : :1:0:/:1543
devices.chrp.IBM.lhea:devices.chrp.IBM.lhea.diag:6.1.8.15: : :C: :Host Ethernet Adapter Diagnostics : : : : : : :1:0:/:1140
devices.chrp.IBM.lhea:devices.chrp.IBM.lhea.rte:6.1.9.100: : :C: :Host Ethernet Adapter (HEA) Runtime Environment : : : : : : :1:0:/:1543
devices.chrp.base:devices.chrp.base.ServiceRM:2.5.0.1: : :C: :RSCT Service Resource Manager: : : : : : :1:0:/:
devices.chrp.base:devices.chrp.base.diag:6.1.9.100: : :C: :RISC CHRP Base System Device Diagnostics : : : : : : :1:0:/:1543
devices.chrp.base:devices.chrp.base.rte:6.1.9.100: : :C: :RISC PC Base System Device Software (CHRP) : : : : : : :1:0:/:1543
devices.chrp.pci:devices.chrp.pci.rte:6.1.9.100: : :C: :PCI Bus Software (CHRP) : : : : : : :1:0:/:1543
devices.chrp.pciex:devices.chrp.pciex.rte:6.1.0.0: : :C: :PCI Express Bus Software (CHRP): : : : : : :1:0:/:0747
devices.chrp.vdevice:devices.chrp.vdevice.rte:6.1.9.100: : :C: :Virtual I/O Bus Support : : : : : : :1:0:/:1543
devices.chrp_lpar.base:devices.chrp_lpar.base.ras:6.1.9.0: : :C: :CHRP LPAR RAS Support : : : : : : :1:0:/:1341
devices.common.IBM.async:devices.common.IBM.async.diag:6.1.6.0: : :C: :Common Serial Adapter Diagnostics : : : : : : :1:0:/:1036
devices.common.IBM.atm:devices.common.IBM.atm.rte:6.1.9.100: : :C: :Common ATM Software : : : : : : :1:0:/:1543
devices.common.IBM.crypt:devices.common.IBM.crypt.rte:6.1.0.0: : :C: :Cryptographic Common Runtime Environment: : : : : : :1:0:/:0747
devices.common.IBM.cx:devices.common.IBM.cx.rte:6.1.9.0: : :C: :CX Common Adapter Software : : : : : : :1:0:/:1341
devices.common.IBM.disk:devices.common.IBM.disk.rte:6.1.9.100: : :C: :Common IBM Disk Software : : : : : : :1:0:/:1543
devices.common.IBM.ethernet:devices.common.IBM.ethernet.rte:6.1.9.100: : :C: :Common Ethernet Software : : : : : : :1:0:/:1543
devices.common.IBM.fc:devices.common.IBM.fc.hba-api:6.1.9.100: : :C: :Common HBA API Library : : : : : : :1:0:/:1543
devices.common.IBM.fc:devices.common.IBM.fc.rte:6.1.9.100: : :C: :Common IBM FC Software : : : : : : :1:0:/:1543
devices.common.IBM.fda:devices.common.IBM.fda.diag:6.1.6.0: : :C: :Common Diskette Adapter and Device Diagnostics : : : : : : :1:0:/:1036
devices.common.IBM.fda:devices.common.IBM.fda.rte:6.1.8.0: : :C: :Common Diskette Device Software : : : : : : :1:0:/:1241
devices.common.IBM.hdlc:devices.common.IBM.hdlc.rte:6.1.9.100: : :C: :Common HDLC Software : : : : : : :1:0:/:1543
devices.common.IBM.hdlc:devices.common.IBM.hdlc.sdlc:6.1.8.0: : :C: :SDLC COMIO Device Driver Emulation : : : : : : :1:0:/:1241
devices.common.IBM.ib:devices.common.IBM.ib.rte:6.1.9.100: : :C: :Infiniband Common Runtime Environment : : : : : : :1:0:/:1543
devices.common.IBM.ide:devices.common.IBM.ide.rte:6.1.6.0: : :C: :Common IDE I/O Controller Software : : : : : : :1:0:/:1036
devices.common.IBM.iscsi:devices.common.IBM.iscsi.rte:6.1.9.15: : :C: :Common iSCSI Files : : : : : : :1:0:/:1415
devices.common.IBM.ktm_std:devices.common.IBM.ktm_std.diag:6.1.0.0: : :C: :Common Keyboard, Mouse, and Tablet Device Diagnostics : : : : : : :1:0:/:0747
devices.common.IBM.ktm_std:devices.common.IBM.ktm_std.rte:6.1.8.0: : :C: :Common Keyboard, Tablet, and Mouse Software : : : : : : :1:0:/:1241
devices.common.IBM.ml:devices.common.IBM.ml:1.4.1.2: : :C:F:Multi Link Interface Runtime: : : : : : :1:0:/:
devices.common.IBM.modemcfg:devices.common.IBM.modemcfg.data:6.1.0.0: : :C: :Sample Service Processor Modem Configuration Files: : : : : : :1:0:/:0747
devices.common.IBM.mpio:devices.common.IBM.mpio.rte:6.1.9.100: : :C: :MPIO Disk Path Control Module : : : : : : :1:0:/:1543
devices.common.IBM.mpt2:devices.common.IBM.mpt2.diag:6.1.8.0: : :C: :Common Code for MPT2 LSI SAS Expansion Adapter Diagnostics : : : : : : :1:0:/:1241
devices.common.IBM.mpt2:devices.common.IBM.mpt2.rte:6.1.9.15: : :C: :MPT SAS Device Software : : : : : : :1:0:/:1415
devices.common.IBM.ppa:devices.common.IBM.ppa.diag:6.1.6.0: : :C: :Common Parallel Printer Adapter Diagnostics : : : : : : :1:0:/:1036
devices.common.IBM.ppa:devices.common.IBM.ppa.rte:6.1.8.0: : :C: :Common Parallel Printer Adapter Software : : : : : : :1:0:/:1241
devices.common.IBM.scsi:devices.common.IBM.scsi.rte:6.1.9.100: : :C: :Common SCSI I/O Controller Software : : : : : : :1:0:/:1543
devices.common.IBM.sissas:devices.common.IBM.sissas.rte:6.1.9.100: : :C: :Common IBM SAS RAID Software : : : : : : :1:0:/:1543
devices.common.IBM.sni:devices.common.IBM.sni.ntbl:1.4.2.0: : :C: :Network Table Runtime: : : : : : :1:0:/:
devices.common.IBM.sni:devices.common.IBM.sni.rte:1.4.2.0: : :C: :Switch Network Interface Runtime: : : : : : :1:0:/:
devices.common.IBM.son:devices.common.IBM.son.diag:6.1.8.0: : :C: :GXT Common Graphics Adapter Diagnostics I : : : : : : :1:0:/:1241
devices.common.IBM.storfwork:devices.common.IBM.storfwork.rte:6.1.9.100: : :C: :Storage Framework Module : : : : : : :1:0:/:1543
devices.common.IBM.tokenring:devices.common.IBM.tokenring.rte:6.1.9.100: : :C: :Common Token Ring Software : : : : : : :1:0:/:1543
devices.common.IBM.usb:devices.common.IBM.usb.diag:6.1.9.100: : :C: :Common USB Adapter Diagnostics : : : : : : :1:0:/:1543
devices.common.IBM.usb:devices.common.IBM.usb.rte:6.1.9.100: : :C: :USB System Software : : : : : : :1:0:/:1543
devices.common.IBM.xhci:devices.common.IBM.xhci.rte:6.1.9.100: : :C: :Common xHCI Adapter Device Software : : : : : : :1:0:/:1543
devices.common.base:devices.common.base.diag:6.1.6.0: : :C: :Common Base System Diagnostics : : : : : : :1:0:/:1036
devices.common.rspcbase:devices.common.rspcbase.rte:6.1.8.0: : :C: :RISC PC Common Base System Device Software : : : : : : :1:0:/:1241
devices.ethernet.ct3:devices.ethernet.ct3.cdli:6.1.9.100: : :C: :10 Gigabit Ethernet Adapter Software : : : : : : :1:0:/:1543
devices.ethernet.ct3:devices.ethernet.ct3.rte:6.1.9.100: : :C: :10 Gigabit Ethernet PCI-Express Host Bus Adapter Software : : : : : : :1:0:/:1543
devices.ethernet.lnc:devices.ethernet.lnc.rte:6.1.9.100: : :C: :10 Gigabit Ethernet PCI-Express Adapter Software (lnc) : : : : : : :1:0:/:1543
devices.ethernet.lnc2:devices.ethernet.lnc2.rte:6.1.9.101: : :C: :10 Gigabit Ethernet PCI-Express Adapter Software (lnc2) : : : : : : :1:0:/:1543
devices.ethernet.mlx:devices.ethernet.mlx.diag:6.1.9.100: : :C: :RoCE Converged Network Adapter Diagnostics : : : : : : :1:0:/:1543
devices.ethernet.mlx:devices.ethernet.mlx.rte:6.1.9.100: : :C: :RoCE Converged Network Adapter : : : : : : :1:0:/:1543
devices.ethernet.shi:devices.ethernet.shi.rte:6.1.9.101: : :C: :10 Gigabit Ethernet PCI-Express Adapter Software (shi) : : : : : : :1:0:/:1543
devices.fcp.disk.array:devices.fcp.disk.array.diag:6.1.6.0: : :C: :Fibre Channel RAID Device Diagnostics : : : : : : :1:0:/:1036
devices.fcp.disk.array:devices.fcp.disk.array.rte:6.1.9.100: : :C: :FC SCSI RAIDiant Array Device Support Software : : : : : : :1:0:/:1543
devices.fcp.disk:devices.fcp.disk.rte:6.1.9.100: : :C: :FC SCSI CD-ROM, Disk, Read/Write Optical Device Software : : : : : : :1:0:/:1543
devices.fcp.tape:devices.fcp.tape.rte:6.1.9.100: : :C: :FC SCSI Tape Device Software : : : : : : :1:0:/:1543
devices.graphics:devices.graphics.com:6.1.8.0: : :C: :Graphics Adapter Common Software : : : : : : :1:0:/:1241
devices.graphics:devices.graphics.voo:6.1.0.0: : :C: :Graphics Adapter VOO and Stereo Software : : : : : : :1:0:/:0747
devices.ide.cdrom:devices.ide.cdrom.diag:6.1.9.100: : :C: :IDE CDROM, Cdrom Device Diagnostics : : : : : : :1:0:/:1543
devices.ide.cdrom:devices.ide.cdrom.rte:6.1.9.0: : :C: :IDE CDROM Device Software : : : : : : :1:0:/:1341
devices.ide.disk:devices.ide.disk.diag:6.1.6.0: : :C: :IDE Disk Device Diagnostics : : : : : : :1:0:/:1036
devices.ide.disk:devices.ide.disk.rte:6.1.8.0: : :C: :IDE Disk Device Software : : : : : : :1:0:/:1241
devices.isa_sio.IBM0017:devices.isa_sio.IBM0017.diag:6.1.6.0: : :C: :Audio Device Diagnostics : : : : : : :1:0:/:1036
devices.isa_sio.IBM0017:devices.isa_sio.IBM0017.rte:6.1.8.15: : :C: :Audio Device : : : : : : :1:0:/:1316
devices.isa_sio.IBM0019:devices.isa_sio.IBM0019.diag:6.1.6.0: : :C: :ISA Tablet Software (IBM0019) Diagnostics : : : : : : :1:0:/:1036
devices.isa_sio.IBM0019:devices.isa_sio.IBM0019.rte:6.1.8.0: : :C: :ISA Tablet Software (IBM0019) : : : : : : :1:0:/:1241
devices.isa_sio.chrp.8042:devices.isa_sio.chrp.8042.diag:6.1.6.0: : :C: :ISA Keyboard & Mouse Diagnostics (CHRP) : : : : : : :1:0:/:1036
devices.isa_sio.chrp.8042:devices.isa_sio.chrp.8042.rte:6.1.8.0: : :C: :ISA Keyboard & Mouse Software (CHRP) : : : : : : :1:0:/:1241
devices.isa_sio.chrp.ecp:devices.isa_sio.chrp.ecp.diag:6.1.0.0: : :C: :CHRP IEEE 1284 Parallel Port Adapter Diagnostics : : : : : : :1:0:/:0747
devices.isa_sio.chrp.ecp:devices.isa_sio.chrp.ecp.rte:6.1.8.0: : :C: :CHRP IEEE1284 Parallel Port Adapter Software : : : : : : :1:0:/:1241
devices.isa_sio.pnpPNP.501:devices.isa_sio.pnpPNP.501.diag:6.1.0.0: : :C: :CHRP Serial Adapter Diagnostics (pnpPNP.501) : : : : : : :1:0:/:0747
devices.isa_sio.pnpPNP.501:devices.isa_sio.pnpPNP.501.rte:6.1.8.0: : :C: :CHRP Serial Adapter Software (pnpPNP.501) : : : : : : :1:0:/:1241
devices.isa_sio.pnpPNP.700:devices.isa_sio.pnpPNP.700.diag:6.1.0.0: : :C: :CHRP Diskette Adapter Diagnostic Software (pnpPNP.700) : : : : : : :1:0:/:0747
devices.isa_sio.pnpPNP.700:devices.isa_sio.pnpPNP.700.rte:6.1.8.0: : :C: :CHRP Diskette Adapter Software (pnpPNP.700) : : : : : : :1:0:/:1241
devices.iscsi.disk:devices.iscsi.disk.rte:6.1.6.15: : :C: :iSCSI Disk Software : : : : : : :1:0:/:1115
devices.iscsi.tape:devices.iscsi.tape.rte:6.1.0.0: : :C: :iSCSI Tape Software: : : : : : :1:0:/:0747
devices.iscsi_sw:devices.iscsi_sw.rte:6.1.9.15: : :C: :iSCSI Software Device Driver : : : : : : :1:0:/:1415
devices.loopback:devices.loopback.rte:6.1.9.100: : :C: :Loopback Device Driver : : : : : : :1:0:/:1543
devices.msg.en_US:devices.msg.en_US.base.com:6.1.4.0: : :C: :Base Sys Device Software Msg - U.S. English : : : : : : :1:0:/:0943
devices.msg.en_US.chrp.IBM.HPS:devices.msg.en_US.chrp.IBM.HPS.hpsfu:1.4.2.0: : :C: :pSeries HPS Func Util Msgs - U.S. English: : : : : : :1:0:/:
devices.msg.en_US.chrp.IBM.HPS:devices.msg.en_US.chrp.IBM.HPS.rte:1.4.2.0: : :C: :pSeries HPS Rte Msgs - U.S. English: : : : : : :1:0:/:
devices.msg.en_US.common.IBM.ml:devices.msg.en_US.common.IBM.ml:1.4.1.0: : :C: :Multi Link Interface Runtime - U.S. English: : : : : : :1:0:/:
devices.msg.en_US.common.IBM.sni:devices.msg.en_US.common.IBM.sni.ntbl:1.4.2.0: : :C: :Network Table Runtime Messages - U.S. English: : : : : : :1:0:/:
devices.msg.en_US.common.IBM.sni:devices.msg.en_US.common.IBM.sni.rte:1.4.2.0: : :C: :Switch Network Interface Runtime Messages - U.S. English: : : : : : :1:0:/:
devices.msg.en_US:devices.msg.en_US.diag.rte:6.1.4.0: : :C: :Device Diagnostics Messages - U.S. English : : : : : : :1:0:/:0943
devices.msg.en_US:devices.msg.en_US.rspc.base.com:6.1.7.0: : :C: :RISC PC Software Messages - U.S. English : : : : : : :1:0:/:1140
devices.msg.en_US:devices.msg.en_US.sys.mca.rte:6.1.4.0: : :C: :Micro Channel Bus Software Msg - U.S. English : : : : : : :1:0:/:0943
devices.pci.00100100:devices.pci.00100100.com:6.1.8.0: : :C: :Common Symbios PCI SCSI I/O Controller Software : : : : : : :1:0:/:1241
devices.pci.00100b00:devices.pci.00100b00.diag:6.1.0.0: : :C: :SYM53C896 Dual Channel PCI-2 Ultra2 SCSI Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.00100b00:devices.pci.00100b00.rte:6.1.0.0: : :C: :SYM53C896 Dual Channel PCI SCSI I/O Controller: : : : : : :1:0:/:0747
devices.pci.00100c00:devices.pci.00100c00.diag:6.1.0.0: : :C: :SYM53C895 LVD PCI SCSI I/O Controller Diagnostics: : : : : : :1:0:/:0747
devices.pci.00100c00:devices.pci.00100c00.rte:6.1.0.0: : :C: :SYM53C895 PCI SCSI I/O Controller Software: : : : : : :1:0:/:0747
devices.pci.00100f00:devices.pci.00100f00.diag:6.1.9.0: : :C: :SYM53C8xxA PCI SCSI I/O Controller Diagnostics : : : : : : :1:0:/:1341
devices.pci.00100f00:devices.pci.00100f00.rte:6.1.8.0: : :C: :SYM53C8xxA PCI SCSI I/O Controller Software : : : : : : :1:0:/:1241
devices.pci.00102100:devices.pci.00102100.diag:6.1.0.0: : :C: :SYM53C1010 Dual Channel PCI Ultra3 SCSI Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.00102100:devices.pci.00102100.rte:6.1.0.0: : :C: :SYM53C1010 PCI Ultra-3 SCSI I/O Controller Software: : : : : : :1:0:/:0747
devices.pci.00105000:devices.pci.00105000.com:6.1.8.15: : :C: :Common SAS Expansion Card Device Software : : : : : : :1:0:/:1316
devices.pci.00105000:devices.pci.00105000.diag:6.1.8.0: : :C: :LSI SAS Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pci.00105000:devices.pci.00105000.rte:6.1.4.0: : :C: :SAS Expansion Card Device Software (00105000) : : : : : : :1:0:/:0943
devices.pci.02105e51:devices.pci.02105e51.X11:6.1.8.0: : :C: :AIXwindows Native Display Adapter Software : : : : : : :1:0:/:1241
devices.pci.02105e51:devices.pci.02105e51.diag:6.1.8.0: : :C: :Native Display Graphics Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pci.02105e51:devices.pci.02105e51.rte:6.1.9.0: : :C: :Native Display Adapter Software : : : : : : :1:0:/:1341
devices.pci.13100560:devices.pci.13100560.diag:6.1.9.0: : :C: :PCI Audio Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.13100560:devices.pci.13100560.rte:6.1.8.0: : :C: :PCI Audio Adapter (13100560) Runtime Software : : : : : : :1:0:/:1241
devices.pci.14100401:devices.pci.14100401.diag:6.1.9.0: : :C: :Gigabit Ethernet-SX PCI Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.14100401:devices.pci.14100401.rte:6.1.9.0: : :C: :Gigabit Ethernet-SX PCI Adapter Software : : : : : : :1:0:/:1341
devices.pci.14100c03:devices.pci.14100c03.diag:6.1.0.0: : :C: :PCI-XDDR Auxiliary Cache Adapter Diagnostics (14100c03): : : : : : :1:0:/:0747
devices.pci.14100c03:devices.pci.14100c03.rte:6.1.0.0: : :C: :PCI-XDDR Auxiliary Cache Adapter Software (14100c03): : : : : : :1:0:/:0747
devices.pci.14100d03:devices.pci.14100d03.diag:6.1.0.0: : :C: :PCI-XDDR Auxiliary Cache Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.14100d03:devices.pci.14100d03.rte:6.1.0.0: : :C: :PCI-XDDR Auxiliary Cache Adapter Software: : : : : : :1:0:/:0747
devices.pci.14101103:devices.pci.14101103.diag:6.1.0.0: : :C: :4-Port 10/100/1000 Base-TX PCI-X Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14101103:devices.pci.14101103.rte:6.1.9.0: : :C: :4-Port 10/100/1000 Base-TX PCI-X Adapter Software : : : : : : :1:0:/:1341
devices.pci.14101403:devices.pci.14101403.diag:6.1.6.0: : :C: :Gigabit Ethernet-SX Adapter Diagnostics : : : : : : :1:0:/:1036
devices.pci.14101403:devices.pci.14101403.rte:6.1.9.100: : :C: :Gigabit Ethernet-SX Adapter Software : : : : : : :1:0:/:1543
devices.pci.14101b02:devices.pci.14101b02.X11:6.1.8.0: : :C: :AIXwindows GXT6500P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14101b02:devices.pci.14101b02.diag:6.1.0.0: : :C: :GXT6500P Graphics Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14101b02:devices.pci.14101b02.rte:6.1.8.0: : :C: :GXT6500P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14101c02:devices.pci.14101c02.X11:6.1.8.0: : :C: :AIXwindows GXT4500P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14101c02:devices.pci.14101c02.diag:6.1.0.0: : :C: :GXT4500P Graphics Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14101c02:devices.pci.14101c02.rte:6.1.8.0: : :C: :GXT4500P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14102203:devices.pci.14102203.diag:6.1.0.0: : :C: :IBM 1 Gigabit-TX iSCSI TOE PCI-X Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.14102203:devices.pci.14102203.rte:6.1.0.0: : :C: :IBM 1 Gigabit-TX iSCSI TOE PCI-X Adapter: : : : : : :1:0:/:0747
devices.pci.14102e00:devices.pci.14102e00.diag:6.1.9.0: : :C: :IBM PCI SCSI RAID Adapter Diagnostics Support : : : : : : :1:0:/:1341
devices.pci.14102e00:devices.pci.14102e00.rte:6.1.9.100: : :C: :IBM PCI SCSI RAID Adapter Device Software Support : : : : : : :1:0:/:1543
devices.pci.14103302:devices.pci.14103302.X11:6.1.7.0: : :C: :AIXwindows GXT135P Graphics Adapter Software : : : : : : :1:0:/:1140
devices.pci.14103302:devices.pci.14103302.diag:6.1.8.0: : :C: :GXT135P Graphics Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pci.14103302:devices.pci.14103302.rte:6.1.8.0: : :C: :GXT135P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14103e00:devices.pci.14103e00.diag:6.1.9.0: : :C: :IBM PCI Tokenring Adapter (14103e00) Diagnostics : : : : : : :1:0:/:1341
devices.pci.14103e00:devices.pci.14103e00.rte:6.1.8.0: : :C: :IBM PCI Token-Ring Adapter Software : : : : : : :1:0:/:1241
devices.pci.14104e00:devices.pci.14104e00.diag:6.1.0.0: : :C: :PCI ATM Adapter (14104e00) Diagnostics: : : : : : :1:0:/:0747
devices.pci.14104e00:devices.pci.14104e00.rte:6.1.0.0: : :C: :PCI ATM Adapter (14104e00) Software: : : : : : :1:0:/:0747
devices.pci.14104f00:devices.pci.14104f00.diag:6.1.0.0: : :C: :PCI ATM Adapter (14104f00) Diagnostics: : : : : : :1:0:/:0747
devices.pci.14104f00:devices.pci.14104f00.rte:6.1.0.0: : :C: :PCI ATM Adapter (14104f00) Software: : : : : : :1:0:/:0747
devices.pci.14105000:devices.pci.14105000.diag:6.1.0.0: : :C: :PCI ATM Adapter (14105000) Diagnostics: : : : : : :1:0:/:0747
devices.pci.14105000:devices.pci.14105000.rte:6.1.0.0: : :C: :PCI ATM Adapter (14105000) Software: : : : : : :1:0:/:0747
devices.pci.14105e01:devices.pci.14105e01.com:6.1.8.0: : :C: :622Mbps ATM PCI Adapter Common Software : : : : : : :1:0:/:1241
devices.pci.14105e01:devices.pci.14105e01.diag:6.1.9.0: : :C: :622Mbps ATM PCI Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.14105e01:devices.pci.14105e01.rte:6.1.0.0: : :C: :622Mbps ATM PCI Adapter Software : : : : : : :1:0:/:0747
devices.pci.14106001:devices.pci.14106001.diag:6.1.0.0: : :C: :64bit/66MHz PCI ATM 155 MMF Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.14106001:devices.pci.14106001.rte:6.1.0.0: : :C: :64bit/66MHz PCI ATM 155 MMF Adapter Software: : : : : : :1:0:/:0747
devices.pci.14106402:devices.pci.14106402.diag:6.1.0.0: : :C: :PCI-X Quad Channel U320 SCSI RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.14106402:devices.pci.14106402.rte:6.1.0.0: : :C: :PCI-X Quad Channel U320 SCSI RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.14106402:devices.pci.14106402.ucode:6.1.0.0: : :C: :PCI-X Quad Channel U320 SCSI RAID Adapter Microcode: : : : : : :1:0:/:0747
devices.pci.14106602:devices.pci.14106602.diag:6.1.6.0: : :C: :PCI-X Dual Channel SCSI Adapter Diagnostics : : : : : : :1:0:/:1036
devices.pci.14106602:devices.pci.14106602.rte:6.1.8.0: : :C: :PCI-X Dual Channel SCSI Adapter Device Software : : : : : : :1:0:/:1241
devices.pci.14106602:devices.pci.14106602.ucode:6.1.8.15: : :C: :PCI-X Dual Channel SCSI Adapter Microcode : : : : : : :1:0:/:1316
devices.pci.14106703:devices.pci.14106703.diag:6.1.0.0: : :C: :PCI-X Gigabit Ethernet-SX Adapter Diagnostics (14106703): : : : : : :1:0:/:0747
devices.pci.14106703:devices.pci.14106703.rte:6.1.0.0: : :C: :Gigabit Ethernet-SX PCI-X Adapter Software: : : : : : :1:0:/:0747
devices.pci.14106802:devices.pci.14106802.diag:6.1.0.0: : :C: :Gigabit Ethernet-SX PCI-X Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14106802:devices.pci.14106802.rte:6.1.9.0: : :C: :Gigabit Ethernet-SX PCI-X Adapter Software : : : : : : :1:0:/:1341
devices.pci.14106902:devices.pci.14106902.diag:6.1.9.0: : :C: :10/100/1000 Base-TX PCI-X Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.14106902:devices.pci.14106902.rte:6.1.9.100: : :C: :10/100/1000 Base-TX PCI-X Adapter Software : : : : : : :1:0:/:1543
devices.pci.14106e01:devices.pci.14106e01.X11:6.1.8.0: : :C: :AIXwindows GXT4000P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14106e01:devices.pci.14106e01.diag:6.1.0.0: : :C: :GXT4000P Graphics Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14106e01:devices.pci.14106e01.rte:6.1.8.0: : :C: :GXT4000P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14107001:devices.pci.14107001.X11:6.1.8.0: : :C: :AIXwindows GXT6000P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14107001:devices.pci.14107001.diag:6.1.0.0: : :C: :GXT6000P Graphics Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14107001:devices.pci.14107001.rte:6.1.8.0: : :C: :GXT6000P Graphics Adapter Software : : : : : : :1:0:/:1241
devices.pci.14107802:devices.pci.14107802.diag:6.1.0.0: : :C: :PCI-X Dual Channel Ultra320 SCSI RAID Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14107802:devices.pci.14107802.rte:6.1.9.100: : :C: :PCI-X Dual Channel Ultra320 SCSI RAID Adapter Software : : : : : : :1:0:/:1543
devices.pci.14107802:devices.pci.14107802.ucode:6.1.8.15: : :C: :PCI-X Dual Channel Ultra320 SCSI RAID Adapter Microcode : : : : : : :1:0:/:1316
devices.pci.14107c00:devices.pci.14107c00.com:6.1.9.0: : :C: :Common ATM Adapter Software : : : : : : :1:0:/:1341
devices.pci.14107c00:devices.pci.14107c00.diag:6.1.9.0: : :C: :PCI ATM Adapter (14107c00) Diagnostics : : : : : : :1:0:/:1341
devices.pci.14107c00:devices.pci.14107c00.rte:6.1.0.0: : :C: :PCI ATM Adapter (14107c00) Software : : : : : : :1:0:/:0747
devices.pci.14108802:devices.pci.14108802.diag:6.1.0.0: : :C: :Gigabit-SX Ethernet PCI-X Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14108802:devices.pci.14108802.rte:6.1.9.0: : :C: :2-Port Gigabit Ethernet-SX PCI-X Adapter Software : : : : : : :1:0:/:1341
devices.pci.14108902:devices.pci.14108902.diag:6.1.0.0: : :C: :10/100/1000 Base-TX PCI-X Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.14108902:devices.pci.14108902.rte:6.1.9.0: : :C: :2-Port 10/100/1000 Base-TX PCI-X Adapter Software : : : : : : :1:0:/:1341
devices.pci.14108c00:devices.pci.14108c00.rte:6.1.8.0: : :C: :ARTIC960Hx 4-Port Selectable PCI Adapter Runtime Software : : : : : : :1:0:/:1241
devices.pci.14108d02:devices.pci.14108d02.diag:6.1.0.0: : :C: :PCI-X DDR Dual Channel SAS RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.14108d02:devices.pci.14108d02.rte:6.1.0.0: : :C: :PCI-XDDR Dual Channel SAS RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.14109f00:devices.pci.14109f00.diag:6.1.8.15: : :C: :IBM PCI 4758 Cryptographic Coprocessor Card Diagnostics : : : : : : :1:0:/:1316
devices.pci.14109f00:devices.pci.14109f00.rte:6.1.8.0: : :C: :IBM 4758 PCI Cryptographic Coprocessor : : : : : : :1:0:/:1241
devices.pci.1410a803:devices.pci.1410a803.diag:6.1.3.0: : :C: :4-port Asynchronous EIA-232 PCI-E Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pci.1410a803:devices.pci.1410a803.rte:6.1.7.15: : :C: :4 Port Async EIA-232 PCIe Adapter Software : : : : : : :1:0:/:1216
devices.pci.1410ba02:devices.pci.1410ba02.diag:6.1.0.0: : :C: :10 Gigabit-SR Ethernet PCI-X Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410ba02:devices.pci.1410ba02.rte:6.1.0.0: : :C: :10 Gigabit-SR Ethernet PCI-X Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410bb02:devices.pci.1410bb02.diag:6.1.9.0: : :C: :10 Gigabit-LR Ethernet PCI-X Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.1410bb02:devices.pci.1410bb02.rte:6.1.8.0: : :C: :10 Gigabit-LR Ethernet PCI-X Adapter Software : : : : : : :1:0:/:1241
devices.pci.1410bd02:devices.pci.1410bd02.diag:6.1.9.0: : :C: :PCI-X266 3GB SAS RAID Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.1410bd02:devices.pci.1410bd02.rte:6.1.7.0: : :C: :PCI-X266 Dual-x4 3Gb SAS RAID Adapter Software : : : : : : :1:0:/:1140
devices.pci.1410be02:devices.pci.1410be02.diag:6.1.0.0: : :C: :PCI-X DDR Dual Channel U320 SCSI RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410be02:devices.pci.1410be02.rte:6.1.0.0: : :C: :PCI-XDDR Dual Channel U320 SCSI RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410bf02:devices.pci.1410bf02.diag:6.1.0.0: : :C: :PCI-X DDR Quad Channel U320 SCSI RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410bf02:devices.pci.1410bf02.rte:6.1.0.0: : :C: :PCI-XDDR Quad Channel U320 SCSI RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410c002:devices.pci.1410c002.diag:6.1.0.0: : :C: :PCI-X DDR Dual Channel U320 SCSI Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410c002:devices.pci.1410c002.rte:6.1.0.0: : :C: :PCI-XDDR Dual Channel U320 SCSI Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410c101:devices.pci.1410c101.diag:6.1.0.0: : :C: :64bit/66MHz PCI ATM 155 UTP Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410c101:devices.pci.1410c101.rte:6.1.0.0: : :C: :64bit/66MHz PCI ATM 155 UTP Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410c302:devices.pci.1410c302.diag:6.1.3.0: : :C: :PCI-X266 Ext Tri-x4 3Gb SAS RAID Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pci.1410c302:devices.pci.1410c302.rte:6.1.7.0: : :C: :PCI-X266 Ext Tri-x4 3Gb SAS RAID Adapter Software : : : : : : :1:0:/:1140
devices.pci.1410cf02:devices.pci.1410cf02.diag:6.1.0.0: : :C: :1000 Base-SX PCI-X iSCSI TOE Adapter Device Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410cf02:devices.pci.1410cf02.rte:6.1.0.0: : :C: :1000 Base-SX PCI-X iSCSI TOE Adapter Device Software: : : : : : :1:0:/:0747
devices.pci.1410d002:devices.pci.1410d002.com:6.1.8.0: : :C: :Common PCI iSCSI TOE Adapter Device Software : : : : : : :1:0:/:1241
devices.pci.1410d002:devices.pci.1410d002.diag:6.1.9.100: : :C: :1000 Base-TX PCI-X iSCSI TOE Adapter Device Diagnostics : : : : : : :1:0:/:1543
devices.pci.1410d002:devices.pci.1410d002.rte:6.1.0.0: : :C: :1000 Base-TX PCI-X iSCSI TOE Adapter Device Software : : : : : : :1:0:/:0747
devices.pci.1410d302:devices.pci.1410d302.diag:6.1.0.0: : :C: :PCI-X Dual Channel Ultra320 SCSI Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410d302:devices.pci.1410d302.rte:6.1.0.0: : :C: :PCI-X Dual Channel U320 SCSI Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410d402:devices.pci.1410d402.diag:6.1.0.0: : :C: :PCI-X Dual Channel U320 SCSI RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410d402:devices.pci.1410d402.rte:6.1.0.0: : :C: :PCI-X Dual Channel U320 SCSI RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410d403:devices.pci.1410d403.rte:6.1.7.15: : :C: :Native 1-Port Asynchronous EIA-232 PCI Adapter Software : : : : : : :1:0:/:1216
devices.pci.1410d502:devices.pci.1410d502.diag:6.1.0.0: : :C: :PCI-X DDR Quad Channel U320 SCSI RAID Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410d502:devices.pci.1410d502.rte:6.1.0.0: : :C: :PCI-XDDR Quad Channel U320 SCSI RAID Adapter Software: : : : : : :1:0:/:0747
devices.pci.1410e202:devices.pci.1410e202.diag:6.1.0.0: : :C: :IBM 1 Gigabit-SX iSCSI TOE PCI-X Adapter Diagnostics: : : : : : :1:0:/:0747
devices.pci.1410e202:devices.pci.1410e202.rte:6.1.0.0: : :C: :IBM 1 Gigabit-SX iSCSI TOE PCI-X Adapter: : : : : : :1:0:/:0747
devices.pci.1410e501:devices.pci.1410e501.diag:6.1.0.0: : :C: :IBM PCI-X 4764 Cryptographic Coprocessor Card Diagnostics : : : : : : :1:0:/:0747
devices.pci.1410e501:devices.pci.1410e501.rte:6.1.8.0: : :C: :IBM PCI-X Cryptographic Coprocessor : : : : : : :1:0:/:1241
devices.pci.1410e601:devices.pci.1410e601.diag:6.1.8.15: : :C: :IBM Cryptographic Accelerator Diagnostics : : : : : : :1:0:/:1036
devices.pci.1410e601:devices.pci.1410e601.rte:6.1.9.0: : :C: :IBM Crypto Accelerator Adapter Software : : : : : : :1:0:/:1341
devices.pci.1410eb02:devices.pci.1410eb02.diag:6.1.9.0: : :C: :10 Gigabit Ethernet-SR PCI-X 2.0 DDR Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.1410eb02:devices.pci.1410eb02.rte:6.1.6.0: : :C: :10 Gigabit Ethernet-SR PCI-X 2.0 DDR Adapter Software : : : : : : :1:0:/:1036
devices.pci.1410ec02:devices.pci.1410ec02.diag:6.1.0.0: : :C: :10 Gigabit Ethernet-LR PCI-X 2.0 DDR Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.1410ec02:devices.pci.1410ec02.rte:6.1.9.100: : :C: :10 Gigabit Ethernet-LR PCI-X 2.0 DDR Adapter Software : : : : : : :1:0:/:1543
devices.pci.1410ff01:devices.pci.1410ff01.diag:6.1.9.0: : :C: :10/100 Mbps Ethernet PCI Adapter II Diagnostics : : : : : : :1:0:/:1341
devices.pci.1410ff01:devices.pci.1410ff01.rte:6.1.9.100: : :C: :10/100 Mbps Ethernet PCI Adapter II Software : : : : : : :1:0:/:1543
devices.pci.22106474:devices.pci.22106474.diag:6.1.0.0: : :C: :USB Host Controller (22106474) Diagnostics : : : : : : :1:0:/:0747
devices.pci.22106474:devices.pci.22106474.rte:6.1.9.100: : :C: :USB Host Controller (22106474) Software : : : : : : :1:0:/:1543
devices.pci.22106974:devices.pci.22106974.rte:6.1.0.0: : :C: :IDE Adapter Driver for AMD 8111 Chip Software: : : : : : :1:0:/:0747
devices.pci.23100020:devices.pci.23100020.diag:6.1.9.0: : :C: :IBM PCI 10/100 Mb Ethernet Adapter (23100020) Diagnostics : : : : : : :1:0:/:1341
devices.pci.23100020:devices.pci.23100020.rte:6.1.8.0: : :C: :IBM PCI 10/100 Ethernet Adapter Software : : : : : : :1:0:/:1241
devices.pci.2b102725:devices.pci.2b102725.X11:6.1.7.0: : :C: :AIXwindows GXT145 Graphics Adapter Software : : : : : : :1:0:/:1140
devices.pci.2b102725:devices.pci.2b102725.diag:6.1.8.0: : :C: :GXT145 2D Graphics Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pci.2b102725:devices.pci.2b102725.rte:6.1.9.100: : :C: :GXT145 Graphics Adapter Software : : : : : : :1:0:/:1543
devices.pci.33103500:devices.pci.33103500.diag:6.1.0.0: : :C: :USB Host Controller (33103500) Diagnostics : : : : : : :1:0:/:0747
devices.pci.33103500:devices.pci.33103500.rte:6.1.9.100: : :C: :USB Host Controller (33103500) Software : : : : : : :1:0:/:1543
devices.pci.3310e000:devices.pci.3310e000.diag:6.1.4.0: : :C: :USB Enhanced Host Controller (3310e000) Diagnostics : : : : : : :1:0:/:0943
devices.pci.3310e000:devices.pci.3310e000.rte:6.1.9.100: : :C: :USB Enhanced Host Controller Adapter (3310e000) Software : : : : : : :1:0:/:1543
devices.pci.331121b9:devices.pci.331121b9.com:6.1.8.0: : :C: :IBM PCI 2-Port Multiprotocol Common Software : : : : : : :1:0:/:1241
devices.pci.331121b9:devices.pci.331121b9.diag:6.1.9.0: : :C: :PCI 2-Port Multiprotocol Adapter (331121b9) Diagnostics : : : : : : :1:0:/:1341
devices.pci.331121b9:devices.pci.331121b9.rte:6.1.8.0: : :C: :IBM PCI 2-Port Multiprotocol Device Driver : : : : : : :1:0:/:1241
devices.pci.4f111100:devices.pci.4f111100.asw:6.1.0.0: : :C: :PCI 8-Port Asynchronous Adapter Software : : : : : : :1:0:/:0747
devices.pci.4f111100:devices.pci.4f111100.com:6.1.9.100: : :C: :Common PCI Asynchronous Adapter Software : : : : : : :1:0:/:1543
devices.pci.4f111100:devices.pci.4f111100.diag:6.1.9.0: : :C: :RISC PC PCI Async 8 Port Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.4f111100:devices.pci.4f111100.rte:6.1.0.0: : :C: :PCI 8-Port Asynchronous Adapter Software : : : : : : :1:0:/:0747
devices.pci.4f111b00:devices.pci.4f111b00.asw:6.1.0.0: : :C: :PCI 128-Port Asynchronous Adapter Software : : : : : : :1:0:/:0747
devices.pci.4f111b00:devices.pci.4f111b00.diag:6.1.8.15: : :C: :RISC PC PCI Async 128 Port Adapter Diagnostics : : : : : : :1:0:/:1316
devices.pci.4f111b00:devices.pci.4f111b00.rte:6.1.0.0: : :C: :PCI 128-Port Asynchronous Adapter Software : : : : : : :1:0:/:0747
devices.pci.4f11c800:devices.pci.4f11c800.diag:6.1.9.0: : :C: :2-port Asynchronous EIA-232 PCI Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pci.4f11c800:devices.pci.4f11c800.rte:6.1.9.100: : :C: :2-Port Asynchronous EIA-232 PCI Adapter Software : : : : : : :1:0:/:1543
devices.pci.5a107512:devices.pci.5a107512.rte:6.1.0.0: : :C: :IDE Adapter Driver for Promise 275 Chip Software: : : : : : :1:0:/:0747
devices.pci.77101223:devices.pci.77101223.com:6.1.8.0: : :C: :PCI FC Adapter (77101223) Common Software : : : : : : :1:0:/:1241
devices.pci.77101223:devices.pci.77101223.diag:6.1.9.100: : :C: :PCI FC Adapter (77101223) Diagnostics : : : : : : :1:0:/:1543
devices.pci.77101223:devices.pci.77101223.rte:6.1.0.0: : :C: :PCI FC Adapter (77101223) Runtime Software : : : : : : :1:0:/:0747
devices.pci.77102224:devices.pci.77102224.com:6.1.9.100: : :C: :PCI-X FC Adapter (77102224) Common Software : : : : : : :1:0:/:1543
devices.pci.77102224:devices.pci.77102224.diag:6.1.8.0: : :C: :PCI-X FC Adapter (77102224) Diagnostics : : : : : : :1:0:/:1241
devices.pci.77102224:devices.pci.77102224.rte:6.1.9.100: : :C: :PCI-X FC Adapter (77102224) Runtime Software : : : : : : :1:0:/:1543
devices.pci.77102e01:devices.pci.77102e01.diag:6.1.0.0: : :C: :1000 Base-TX PCI-X iSCSI TOE Adapter Device Diagnostics: : : : : : :1:0:/:0747
devices.pci.77102e01:devices.pci.77102e01.rte:6.1.0.0: : :C: :PCI-X 1000 Base-TX iSCSI TOE Adapter Device Software: : : : : : :1:0:/:0747
devices.pci.99172604:devices.pci.99172604.diag:6.1.4.0: : :C: :USB Enhanced Host Controller (99172604) Diagnostics : : : : : : :1:0:/:0943
devices.pci.99172604:devices.pci.99172604.rte:6.1.9.15: : :C: :USB Enhanced Host Controller Adapter (99172604) Software : : : : : : :1:0:/:1415
devices.pci.99172704:devices.pci.99172704.diag:6.1.0.0: : :C: :USB Host Controller (99172704) Diagnostics : : : : : : :1:0:/:0747
devices.pci.99172704:devices.pci.99172704.rte:6.1.9.100: : :C: :USB Host Controller (99172704) Software : : : : : : :1:0:/:1543
devices.pci.a8135201:devices.pci.a8135201.diag:6.1.0.0: : :C: :2-port Asynchronous EIA-232 PCI Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.a8135201:devices.pci.a8135201.rte:6.1.7.15: : :C: :Native 2-Port Asynchronous EIA-232 PCI Adapter Software : : : : : : :1:0:/:1216
devices.pci.ad100501:devices.pci.ad100501.rte:6.1.8.0: : :C: :IDE Adapter Driver for Winbond 553F Chip Software : : : : : : :1:0:/:1241
devices.pci.b315445a:devices.pci.b315445a.diag:6.1.7.0: : :C: :1X/4X Infiniband Device Diagnostics : : : : : : :1:0:/:1140
devices.pci.b315445a:devices.pci.b315445a.rte:6.1.8.0: : :C: :PCI 1x/4x Infiniband Device Driver : : : : : : :1:0:/:1241
devices.pci.c1110358:devices.pci.c1110358.diag:6.1.0.0: : :C: :USB Open Host Controller Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pci.c1110358:devices.pci.c1110358.rte:6.1.9.100: : :C: :USB Host Controller (c1110358) Software : : : : : : :1:0:/:1543
devices.pci.df1000f7:devices.pci.df1000f7.com:6.1.9.100: : :C: :Common PCI FC Adapter Device Software : : : : : : :1:0:/:1543
devices.pci.df1000f7:devices.pci.df1000f7.diag:6.1.9.100: : :C: :PCI FC Adapter Device Diagnostics : : : : : : :1:0:/:1543
devices.pci.df1000f7:devices.pci.df1000f7.rte:6.1.0.0: : :C: :PCI FC Adapter Device Software : : : : : : :1:0:/:0748
devices.pci.df1000f9:devices.pci.df1000f9.diag:6.1.0.0: : :C: :64-bit PCI FC Adapter Device Diagnostics: : : : : : :1:0:/:0747
devices.pci.df1000f9:devices.pci.df1000f9.rte:6.1.0.0: : :C: :64-bit PCI FC Adapter Device Software: : : : : : :1:0:/:0747
devices.pci.df1000fa:devices.pci.df1000fa.diag:6.1.0.0: : :C: :FC PCI-X Adapter Device Diagnostics : : : : : : :1:0:/:0747
devices.pci.df1000fa:devices.pci.df1000fa.rte:6.1.2.0: : :C: :FC PCI-X Adapter Device Software : : : : : : :1:0:/:0846
devices.pci.df1000fd:devices.pci.df1000fd.diag:6.1.0.0: : :C: :FC PCI-X Adapter Device Diagnostics : : : : : : :1:0:/:0747
devices.pci.df1000fd:devices.pci.df1000fd.rte:6.1.6.0: : :C: :4Gb PCI-X FC Adapter Device Software : : : : : : :1:0:/:1036
devices.pci.df1023fd:devices.pci.df1023fd.diag:6.1.0.0: : :C: :4Gb PCI-X FC Adapter (df1023fd) Device Diagnostics : : : : : : :1:0:/:0747
devices.pci.df1023fd:devices.pci.df1023fd.rte:6.1.6.0: : :C: :4Gb PCI-X FC Adapter (df1023fd) Device Software : : : : : : :1:0:/:1036
devices.pci.df1080f9:devices.pci.df1080f9.diag:6.1.0.0: : :C: :PCI-X FC Adapter Device Diagnostics : : : : : : :1:0:/:0747
devices.pci.df1080f9:devices.pci.df1080f9.rte:6.1.2.0: : :C: :PCI-X FC Adapter Device Software : : : : : : :1:0:/:0846
devices.pci.e414a816:devices.pci.e414a816.diag:6.1.8.0: : :C: :Gigabit Ethernet Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pci.e414a816:devices.pci.e414a816.rte:6.1.8.0: : :C: :Gigabit Ethernet-SX Adapter Software : : : : : : :1:0:/:1241
devices.pci.isa:devices.pci.isa.rte:6.1.8.0: : :C: :ISA Bus Bridge Software (CHRP) : : : : : : :1:0:/:1241
devices.pci.pci:devices.pci.pci.rte:6.1.0.0: : :C: :PCI Bus Bridge Software (CHRP): : : : : : :1:0:/:0747
devices.pciex.001072001410ea03:devices.pciex.001072001410ea03.diag:6.1.6.0: : :C: :LSI 6Gb 2-port SAS Expansion Adapter Diagnostics : : : : : : :1:0:/:1115
devices.pciex.001072001410ea03:devices.pciex.001072001410ea03.rte:6.1.8.15: : :C: :PCIe2 SAS Adapter Dual-port 6Gb Device Software : : : : : : :1:0:/:1316
devices.pciex.001072001410f603:devices.pciex.001072001410f603.diag:6.1.6.0: : :C: :LSI 6Gb 4-port SAS Expansion Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.001072001410f603:devices.pciex.001072001410f603.rte:6.1.8.15: : :C: :PCIe2 SAS Adapter Quad-port 6Gb Device Software : : : : : : :1:0:/:1316
devices.pciex.14103903:devices.pciex.14103903.diag:6.1.9.0: : :C: :PCI Express 3Gb SAS RAID Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pciex.14103903:devices.pciex.14103903.rte:6.1.7.0: : :C: :PCI Express 3GB SAS RAID Adapter Software : : : : : : :1:0:/:1140
devices.pciex.14103d03:devices.pciex.14103d03.diag:6.1.9.100: : :C: :PCI Express 6GB SAS RAID Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.14103d03:devices.pciex.14103d03.rte:6.1.8.0: : :C: :PCI Express 6GB SAS RAID Adapter Software : : : : : : :1:0:/:1241
devices.pciex.14103f03:devices.pciex.14103f03.diag:6.1.9.100: : :C: :2-Port Gigabit Ethernet-SX PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.14103f03:devices.pciex.14103f03.rte:6.1.9.0: : :C: :2-Port Gigabit Ethernet-SX PCI-Express Adapter Software : : : : : : :1:0:/:1341
devices.pciex.14104003:devices.pciex.14104003.diag:6.1.0.0: : :C: :2-Port 10/100/1000 Base-TX PCI-Express Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pciex.14104003:devices.pciex.14104003.rte:6.1.9.0: : :C: :2-Port 10/100/1000 Base-TX PCI-Express Adapter Software : : : : : : :1:0:/:1341
devices.pciex.14104a03:devices.pciex.14104a03.diag:6.1.9.100: : :C: :PCIe3 6GB SAS RAID Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.14104a03:devices.pciex.14104a03.rte:6.1.9.100: : :C: :PCIe3 6GB SAS RAID Adapter Software : : : : : : :1:0:/:1543
devices.pciex.14104b0414104b04:devices.pciex.14104b0414104b04.com:6.1.9.100: : :C: :Common PCIe FPGA Accelerator Adapter Device Software : : : : : : :1:0:/:1543
devices.pciex.14104b0414104b04:devices.pciex.14104b0414104b04.diag:6.1.9.100: : :C: :PCIe FPGA Accelrator Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.14104b0414104b04:devices.pciex.14104b0414104b04.rte:6.1.9.15: : :C: :PCIe FPGA Accelrator Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.14106803:devices.pciex.14106803.diag:6.1.0.0: : :C: :4-Port 10/100/1000 Base-TX PCI Express Adapter Diagnostics : : : : : : :1:0:/:0747
devices.pciex.14106803:devices.pciex.14106803.rte:6.1.9.0: : :C: :4-Port 10/100/1000 Base-TX PCI-Express Adapter Software : : : : : : :1:0:/:1341
devices.pciex.14107a0314107b03:devices.pciex.14107a0314107b03.diag:6.1.9.100: : :C: :IBM Y4 PCI-E Cryptographic CoProcessor Model 4765 (14107a0314107b03) Diagnostics : : : : : : :1:0:/:1543
devices.pciex.14107a0314107b03:devices.pciex.14107a0314107b03.rte:6.1.9.100: : :C: :IBM Y4 PCI-E Cryptographic Coprocessor (14107a0314107b03) Device Software : : : : : : :1:0:/:1543
devices.pciex.151438c1:devices.pciex.151438c1.diag:6.1.9.0: : :C: :PCIe Async EIA-232 Controller Diagnostics : : : : : : :1:0:/:1341
devices.pciex.151438c1:devices.pciex.151438c1.rte:6.1.7.15: : :C: :PCIe Async EIA-232 Controller : : : : : : :1:0:/:1216
devices.pciex.2514300014108c03:devices.pciex.2514300014108c03.diag:6.1.9.0: : :C: :10 Gigabit Ethernet-SR PCI Express Adapter Diagnostics Software (2514300014108c03) : : : : : : :1:0:/:1341
devices.pciex.2514300014108c03:devices.pciex.2514300014108c03.rte:6.1.8.15: : :C: :10 Gigabit Ethernet-SR PCI-Express Host Bus Adapter : : : : : : :1:0:/:1316
devices.pciex.251430001410a303:devices.pciex.251430001410a303.diag:6.1.3.0: : :C: :10 Gigabit Ethernet-CX4 PCI Express Adapter Diagnostics Software (251430001410a303) : : : : : : :1:0:/:0943
devices.pciex.251430001410a303:devices.pciex.251430001410a303.rte:6.1.8.15: : :C: :10 Gigabit Ethernet-CX4 PCI-Express Host Bus Adapter : : : : : : :1:0:/:1316
devices.pciex.2514310025140100:devices.pciex.2514310025140100.diag:6.1.4.0: : :C: :10 Gigabit Ethernet PCI-Express Host Bus Adapter Diagnostics Software (2514310025140100) : : : : : : :1:0:/:0943
devices.pciex.2514310025140100:devices.pciex.2514310025140100.rte:6.1.8.15: : :C: :10 Gigabit Ethernet PCI-Express Host Bus Adapter : : : : : : :1:0:/:1316
devices.pciex.4c10418214109e04:devices.pciex.4c10418214109e04.diag:6.1.9.100: : :C: :PCIe2 USB 3.0 xHCI 4-Port Adapter Device Diagnostics : : : : : : :1:0:/:1543
devices.pciex.4c10418214109e04:devices.pciex.4c10418214109e04.rte:6.1.9.100: : :C: :PCIe2 USB 3.0 xHCI 4-Port Adapter Device Software : : : : : : :1:0:/:1543
devices.pciex.4c1041821410b204:devices.pciex.4c1041821410b204.diag:6.1.9.100: : :C: :Integrated PCIe2 USB 3.0 xHCI Controller Device Diagnostics : : : : : : :1:0:/:1543
devices.pciex.4c1041821410b204:devices.pciex.4c1041821410b204.rte:6.1.9.100: : :C: :Integrated PCIe2 USB 3.0 xHCI Controller Device Software : : : : : : :1:0:/:1543
devices.pciex.4f11f60014102204:devices.pciex.4f11f60014102204.diag:6.1.7.0: : :C: :PCIe 2-port Async EIA-232 Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.4f11f60014102204:devices.pciex.4f11f60014102204.rte:6.1.7.15: : :C: :PCIe 2-port Async EIA-232 Adapter : : : : : : :1:0:/:1216
devices.pciex.771000801410b003:devices.pciex.771000801410b003.diag:6.1.4.0: : :C: :10 Gb FCoE PCI Express Dual Port Adapter Diagnostics : : : : : : :1:0:/:1015
devices.pciex.771000801410b003:devices.pciex.771000801410b003.rte:6.1.9.100: : :C: :10 Gb Ethernet-SR PCI Express Dual Port Adapter Software : : : : : : :1:0:/:1543
devices.pciex.7710008077108001:devices.pciex.7710008077108001.diag:6.1.4.0: : :C: :10 Gb FCoE PCI Express Dual Port Adapter Diagnostics : : : : : : :1:0:/:0943
devices.pciex.7710008077108001:devices.pciex.7710008077108001.rte:6.1.5.0: : :C: :10 Gb Ethernet PCI Express Dual Port Adapter Software : : : : : : :1:0:/:1015
devices.pciex.771001801410af03:devices.pciex.771001801410af03.diag:6.1.9.100: : :C: :10 Gb FCoE PCI Express Dual Port Adapter (771001801410af03) Diagnostics : : : : : : :1:0:/:1543
devices.pciex.771001801410af03:devices.pciex.771001801410af03.rte:6.1.9.15: : :C: :10 Gb FCoE PCI Express Dual Port Adapter (771001801410af03) Device Software : : : : : : :1:0:/:1415
devices.pciex.7710018077107f01:devices.pciex.7710018077107f01.diag:6.1.8.0: : :C: :10 Gb FCoE PCIe Blade Expansion Card (7710018077107f01) Diagnostics : : : : : : :1:0:/:1241
devices.pciex.7710018077107f01:devices.pciex.7710018077107f01.rte:6.1.8.0: : :C: :10 Gb FCoE PCIe Blade Expansion Card (7710018077107f01) Device Software : : : : : : :1:0:/:1241
devices.pciex.77103224:devices.pciex.77103224.diag:6.1.8.0: : :C: :PCI Express FC Adapter Diagnostics (77103224) : : : : : : :1:0:/:1241
devices.pciex.77103224:devices.pciex.77103224.rte:6.1.9.100: : :C: :PCI Express 4Gb FC Adapter (77103224) Device Software : : : : : : :1:0:/:1543
devices.pciex.7710322514101e04:devices.pciex.7710322514101e04.diag:6.1.7.0: : :C: :Low Profile 8Gb 4-Port PCIe2 FC (7710322514101e04) Diagnostic Software : : : : : : :1:0:/:1216
devices.pciex.7710322514101e04:devices.pciex.7710322514101e04.rte:6.1.9.100: : :C: :Low Profile 8Gb 4-Port PCIe2 FC (7710322514101e04) Device Software : : : : : : :1:0:/:1543
devices.pciex.7710322577106501:devices.pciex.7710322577106501.diag:6.1.8.0: : :C: :4Gb PCIe FC Blade Expansion Card (7710322577106501) Diagnostics : : : : : : :1:0:/:1241
devices.pciex.7710322577106501:devices.pciex.7710322577106501.rte:6.1.8.0: : :C: :4Gb PCIe FC Blade Expansion Card (7710322577106501) Device Software : : : : : : :1:0:/:1241
devices.pciex.7710322577106601:devices.pciex.7710322577106601.diag:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577106601) Diagnostic Software : : : : : : :1:0:/:1241
devices.pciex.7710322577106601:devices.pciex.7710322577106601.rte:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577106601) Device Software : : : : : : :1:0:/:1241
devices.pciex.7710322577106801:devices.pciex.7710322577106801.diag:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577106801) Diagnostics : : : : : : :1:0:/:1241
devices.pciex.7710322577106801:devices.pciex.7710322577106801.rte:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577106801) Device Software : : : : : : :1:0:/:1241
devices.pciex.7710322577107501:devices.pciex.7710322577107501.diag:6.1.8.0: : :C: :Dual Port 8Gb FC Mezzanine Card (7710322577107501) Diagnostic Software : : : : : : :1:0:/:1241
devices.pciex.7710322577107501:devices.pciex.7710322577107501.rte:6.1.9.15: : :C: :Dual Port 8Gb FC Mezzanine Card (7710322577107501) Device Software : : : : : : :1:0:/:1415
devices.pciex.7710322577107601:devices.pciex.7710322577107601.diag:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577107601) Diagnostics : : : : : : :1:0:/:1241
devices.pciex.7710322577107601:devices.pciex.7710322577107601.rte:6.1.8.0: : :C: :8Gb PCIe FC Blade Expansion Card (7710322577107601) Device Software : : : : : : :1:0:/:1241
devices.pciex.8680c71014108003:devices.pciex.8680c71014108003.diag:6.1.9.100: : :C: :10 Gigabit Ethernet-LR PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.8680c71014108003:devices.pciex.8680c71014108003.rte:6.1.9.100: : :C: :10 Gigabit Ethernet-LR PCI-Express Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a219100714100904:devices.pciex.a219100714100904.diag:6.1.7.0: : :C: :Int Multifunction Card w/ SR Optical 10GbE Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.a219100714100904:devices.pciex.a219100714100904.rte:6.1.9.100: : :C: :Int Multifunction Card w/ SR Optical 10GbE Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a219100714100a04:devices.pciex.a219100714100a04.diag:6.1.7.0: : :C: :Int Multifunction Card w/ Copper SFP+ 10GbE Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.a219100714100a04:devices.pciex.a219100714100a04.rte:6.1.9.100: : :C: :Int Multifunction Card w/ Copper SFP+ 10GbE Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a21910071410d003:devices.pciex.a21910071410d003.diag:6.1.9.100: : :C: :PCIe2 2-port 10GbE SR Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.a21910071410d003:devices.pciex.a21910071410d003.rte:6.1.9.100: : :C: :PCIe2 2-port 10GbE SR Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a21910071410d103:devices.pciex.a21910071410d103.diag:6.1.9.0: : :C: :PCIe2 2-port 10GbE SFP Copper Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pciex.a21910071410d103:devices.pciex.a21910071410d103.rte:6.1.9.100: : :C: :PCIe2 2-port 10GbE SFP Copper Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a21910071410d203:devices.pciex.a21910071410d203.diag:6.1.7.0: : :C: :Int Multifunction Card w/ Base-TX Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.a21910071410d203:devices.pciex.a21910071410d203.rte:6.1.9.100: : :C: :Int Multifunction Card w/ Base-TX Adapter Software : : : : : : :1:0:/:1543
devices.pciex.a2191007df1033e7:devices.pciex.a2191007df1033e7.diag:6.1.7.0: : :C: :10GbE 4 port PCIe2 Mezz Adapter Diagnostics : : : : : : :1:0:/:1140
devices.pciex.a2191007df1033e7:devices.pciex.a2191007df1033e7.rte:6.1.9.100: : :C: :10GbE 4-port PCIe2 Mezz Adapter Software : : : : : : :1:0:/:1543
devices.pciex.b31503101410b504:devices.pciex.b31503101410b504.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b31503101410b504) : : : : : : :1:0:/:1543
devices.pciex.b31503101410b504:devices.pciex.b31503101410b504.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b31503101410b504) : : : : : : :1:0:/:1543
devices.pciex.b31507101410e704:devices.pciex.b31507101410e704.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b31507101410e704) : : : : : : :1:0:/:1543
devices.pciex.b31507101410e704:devices.pciex.b31507101410e704.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b31507101410e704) : : : : : : :1:0:/:1543
devices.pciex.b31507101410eb04:devices.pciex.b31507101410eb04.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b31507101410eb04) : : : : : : :1:0:/:1543
devices.pciex.b31507101410eb04:devices.pciex.b31507101410eb04.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b31507101410eb04) : : : : : : :1:0:/:1543
devices.pciex.b3153c67:devices.pciex.b3153c67.diag:6.1.9.100: : :C: :PCIe Dual Port HCA QDR Infiniband Device Diagnostics : : : : : : :1:0:/:1543
devices.pciex.b3153c67:devices.pciex.b3153c67.rte:6.1.9.100: : :C: :4X PCI-E QDR Infiniband Device Driver : : : : : : :1:0:/:1543
devices.pciex.b3154a63:devices.pciex.b3154a63.diag:6.1.9.100: : :C: :PCI-E 4X DDR Infiniband Device Diagnostics : : : : : : :1:0:/:1543
devices.pciex.b3154a63:devices.pciex.b3154a63.rte:6.1.9.100: : :C: :4X PCI-E DDR Infiniband Device Driver : : : : : : :1:0:/:1543
devices.pciex.b315506714101604:devices.pciex.b315506714101604.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b315506714101604) : : : : : : :1:0:/:1543
devices.pciex.b315506714101604:devices.pciex.b315506714101604.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b315506714101604) : : : : : : :1:0:/:1543
devices.pciex.b315506714106104:devices.pciex.b315506714106104.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b315506714106104) : : : : : : :1:0:/:1543
devices.pciex.b315506714106104:devices.pciex.b315506714106104.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b315506714106104) : : : : : : :1:0:/:1543
devices.pciex.b3155067b3157265:devices.pciex.b3155067b3157265.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b3155067b3157265) : : : : : : :1:0:/:1543
devices.pciex.b3155067b3157265:devices.pciex.b3155067b3157265.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b3155067b3157265) : : : : : : :1:0:/:1543
devices.pciex.b3155067b3157365:devices.pciex.b3155067b3157365.diag:6.1.9.100: : :C: :RoCE Host Bus Adapter Diagnostics (b3155067b3157365) : : : : : : :1:0:/:1543
devices.pciex.b3155067b3157365:devices.pciex.b3155067b3157365.rte:6.1.9.100: : :C: :RoCE Host Bus Adapter (b3155067b3157365) : : : : : : :1:0:/:1543
devices.pciex.b3157862:devices.pciex.b3157862.diag:6.1.0.0: : :C: :PCIe-X 4x Infiniband Diagnostics: : : : : : :1:0:/:0747
devices.pciex.b3157862:devices.pciex.b3157862.rte:6.1.0.0: : :C: :PCIe-X 4x Infiniband Device Driver: : : : : : :1:0:/:0747
devices.pciex.df1000e214105e04:devices.pciex.df1000e214105e04.diag:6.1.8.1: : :C: :GX++ 16Gb FC 2 Port Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1000e214105e04:devices.pciex.df1000e214105e04.rte:6.1.9.0: : :C: :GX++ 16Gb FC 2 Port Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1000e21410f103:devices.pciex.df1000e21410f103.diag:6.1.8.0: : :C: :16Gb FC PCIe2 2 Port Adapter Diagnostics : : : : : : :1:0:/:1216
devices.pciex.df1000e21410f103:devices.pciex.df1000e21410f103.rte:6.1.9.0: : :C: :16Gb FC PCIe2 2 Port Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1000e2df1002e2:devices.pciex.df1000e2df1002e2.diag:6.1.8.0: : :C: :PCIe2 2-Port 16Gb FC Mezzanine Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1000e2df1002e2:devices.pciex.df1000e2df1002e2.rte:6.1.9.0: : :C: :PCIe2 2-Port 16Gb FC Mezzanine Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1000e2df1082e2:devices.pciex.df1000e2df1082e2.diag:6.1.8.15: : :C: :4-Port 16Gb FC Mezzanine Adapter Device Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1000e2df1082e2:devices.pciex.df1000e2df1082e2.rte:6.1.9.15: : :C: :4-Port 16Gb FC Mezzanine Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1000f114100104:devices.pciex.df1000f114100104.diag:6.1.7.0: : :C: :8Gb FC PCI Express Quad Port Adapter Device Diagnostics : : : : : : :1:0:/:1140
devices.pciex.df1000f114100104:devices.pciex.df1000f114100104.rte:6.1.9.15: : :C: :8Gb FC PCI Express Quad Port Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1000f114108a03:devices.pciex.df1000f114108a03.diag:6.1.2.0: : :C: :8Gb PCI-E FC Adapter (df1000f114108a03) Device Diagnostics : : : : : : :1:0:/:0846
devices.pciex.df1000f114108a03:devices.pciex.df1000f114108a03.rte:6.1.9.15: : :C: :8Gb FC PCI Express Dual Port Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1000f1df1024f1:devices.pciex.df1000f1df1024f1.diag:6.1.3.0: : :C: :8Gb PCI-E FC Adapter (df1000f1df1024f1) Device Diagnostics : : : : : : :1:0:/:1036
devices.pciex.df1000f1df1024f1:devices.pciex.df1000f1df1024f1.rte:6.1.6.0: : :C: :8Gb PCIe FC Blade Expansion Card (df1000f1df1024f1) Device Software : : : : : : :1:0:/:1036
devices.pciex.df1000fe:devices.pciex.df1000fe.diag:6.1.0.0: : :C: :4Gb FC PCI Express Adapter Device Diagnostics : : : : : : :1:0:/:0747
devices.pciex.df1000fe:devices.pciex.df1000fe.rte:6.1.9.15: : :C: :4Gb FC PCI Express Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1020e214100f04:devices.pciex.df1020e214100f04.diag:6.1.9.15: : :C: :PCIe2 10GbE SFP+ SR Adapter Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1020e214100f04:devices.pciex.df1020e214100f04.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103604:devices.pciex.df1020e214103604.diag:6.1.8.15: : :C: :PCIe2 10GbE SFP+ SR 4-port Adapter Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1020e214103604:devices.pciex.df1020e214103604.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR 4-port Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103804:devices.pciex.df1020e214103804.diag:6.1.9.0: : :C: :PCIe2 10GBaseT 4-port Adapter Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1020e214103804:devices.pciex.df1020e214103804.rte:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103904:devices.pciex.df1020e214103904.diag:6.1.8.15: : :C: :PCIe2 10GbE SFP+ Cu 4-port Adapter Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1020e214103904:devices.pciex.df1020e214103904.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu 4-port Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103b04:devices.pciex.df1020e214103b04.diag:6.1.8.15: : :C: :PCIe2 10GBaseT 4-port Adapter Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1020e214103b04:devices.pciex.df1020e214103b04.rte:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103c04:devices.pciex.df1020e214103c04.diag:6.1.9.15: : :C: :PCIe2 10/100/1000 Base-TX Adapter Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1020e214103c04:devices.pciex.df1020e214103c04.rte:6.1.9.100: : :C: :PCIe2 10/100/1000 Base-TX Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103d04:devices.pciex.df1020e214103d04.diag:6.1.9.0: : :C: :PCIe2 10GbE SFP+ Cu 4-port Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pciex.df1020e214103d04:devices.pciex.df1020e214103d04.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214103f04:devices.pciex.df1020e214103f04.diag:6.1.9.0: : :C: :PCIe2 1GbaseT SFP+ Cu 4-port Adapter Diagnostics : : : : : : :1:0:/:1341
devices.pciex.df1020e214103f04:devices.pciex.df1020e214103f04.rte:6.1.9.100: : :C: :PCIe2 100/1000 Base-TX Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214104004:devices.pciex.df1020e214104004.diag:6.1.9.15: : :C: :PCIe2 10GbE SFP+ LR 4-port Adapter Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1020e214104004:devices.pciex.df1020e214104004.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ LR Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214104204:devices.pciex.df1020e214104204.diag:6.1.9.15: : :C: :PCIe2 100/1000 Base-TX Adapter Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1020e214104204:devices.pciex.df1020e214104204.rte:6.1.9.100: : :C: :PCIe2 100/1000 Base-TX Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214105104:devices.pciex.df1020e214105104.diag:6.1.8.0: : :C: :PCIe2 10GbE Mezz Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1020e214105104:devices.pciex.df1020e214105104.rte:6.1.9.100: : :C: :PCIe2 10GbE Mezz Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e214105d04:devices.pciex.df1020e214105d04.diag:6.1.8.0: : :C: :PCIe2 10GbE 2-port GX++ Gen2 Converged Network Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1020e214105d04:devices.pciex.df1020e214105d04.rte:6.1.9.100: : :C: :PCIe2 10GbE 2-port GX++ Gen2 Converged Network Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1020e21410e304:devices.pciex.df1020e21410e304.diag:6.1.9.100: : :C: :PCIe3 4-Port 10GbE SR Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1020e21410e304:devices.pciex.df1020e21410e304.rte:6.1.9.100: : :C: :PCIe3 4-Port 10GbE SR Adapter : : : : : : :1:0:/:1543
devices.pciex.df1020e21410e404:devices.pciex.df1020e21410e404.diag:6.1.9.100: : :C: :PCIe3 4-Port 10GbE CU Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1020e21410e404:devices.pciex.df1020e21410e404.rte:6.1.9.100: : :C: :PCIe3 4-Port 10GbE CU Adapter : : : : : : :1:0:/:1543
devices.pciex.df1028e214100f04:devices.pciex.df1028e214100f04.diag:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214100f04:devices.pciex.df1028e214100f04.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103604:devices.pciex.df1028e214103604.diag:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103604:devices.pciex.df1028e214103604.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ SR 4-port VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103804:devices.pciex.df1028e214103804.diag:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103804:devices.pciex.df1028e214103804.rte:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103904:devices.pciex.df1028e214103904.diag:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103904:devices.pciex.df1028e214103904.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu 4-port VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103b04:devices.pciex.df1028e214103b04.diag:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103b04:devices.pciex.df1028e214103b04.rte:6.1.9.100: : :C: :PCIe2 10GBaseT 4-port VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103c04:devices.pciex.df1028e214103c04.diag:6.1.9.100: : :C: :PCIe2 10/100/1000 Base-TX VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103c04:devices.pciex.df1028e214103c04.rte:6.1.9.100: : :C: :PCIe2 10/100/1000 Base-TX VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103d04:devices.pciex.df1028e214103d04.diag:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103d04:devices.pciex.df1028e214103d04.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ Cu VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214103f04:devices.pciex.df1028e214103f04.diag:6.1.9.100: : :C: :PCIe2 1GbaseT SFP+ Cu 4-port VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214103f04:devices.pciex.df1028e214103f04.rte:6.1.9.100: : :C: :PCIe2 100/1000 Base-TX VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214104004:devices.pciex.df1028e214104004.diag:6.1.9.100: : :C: :PCIe2 10GbE SFP+ LR VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214104004:devices.pciex.df1028e214104004.rte:6.1.9.100: : :C: :PCIe2 10GbE SFP+ LR VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e214104204:devices.pciex.df1028e214104204.diag:6.1.9.100: : :C: :PCIe2 100/1000 Base-TX VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e214104204:devices.pciex.df1028e214104204.rte:6.1.9.100: : :C: :PCIe2 100/1000 Base-TX VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e21410e304:devices.pciex.df1028e21410e304.diag:6.1.9.100: : :C: :PCIe3 4-Port 10GbE SR VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e21410e304:devices.pciex.df1028e21410e304.rte:6.1.9.100: : :C: :PCIe3 4-Port 10GbE SR VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1028e21410e404:devices.pciex.df1028e21410e404.diag:6.1.9.100: : :C: :PCIe3 4-Port 10GbE CU VF Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1028e21410e404:devices.pciex.df1028e21410e404.rte:6.1.9.100: : :C: :PCIe3 4-Port 10GbE CU VF Adapter Software : : : : : : :1:0:/:1543
devices.pciex.df1060e214101004:devices.pciex.df1060e214101004.diag:6.1.8.0: : :C: :PCIe2 10GbE FCoE 4 Port Adapter Diagnostics : : : : : : :1:0:/:1216
devices.pciex.df1060e214101004:devices.pciex.df1060e214101004.rte:6.1.9.0: : :C: :10Gb FCoE PCIe2 4 Port Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1060e214103404:devices.pciex.df1060e214103404.com:6.1.9.100: : :C: :Common PCIe2 FC Adapter Device Software : : : : : : :1:0:/:1543
devices.pciex.df1060e214103404:devices.pciex.df1060e214103404.diag:6.1.9.100: : :C: :PCIe2 10Gb 4-Port FCoE Mezzanine Adapter Device Diagnostics : : : : : : :1:0:/:1543
devices.pciex.df1060e214103404:devices.pciex.df1060e214103404.rte:6.1.8.0: : :C: :PCIe2 10Gb 4-Port FCoE Mezzanine Adapter Device Software : : : : : : :1:0:/:1241
devices.pciex.df1060e214103704:devices.pciex.df1060e214103704.diag:6.1.8.15: : :C: :Integrated 10Gb 4-Port FCoE Adapter Device Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1060e214103704:devices.pciex.df1060e214103704.rte:6.1.9.0: : :C: :Integrated 10Gb 4-Port FCoE Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1060e214103a04:devices.pciex.df1060e214103a04.diag:6.1.8.15: : :C: :Integrated 10Gb Cu 4-Port FCoE Adapter Device Diagnostics : : : : : : :1:0:/:1316
devices.pciex.df1060e214103a04:devices.pciex.df1060e214103a04.rte:6.1.9.0: : :C: :Integrated 10Gb Cu 4-Port FCoE Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1060e214103e04:devices.pciex.df1060e214103e04.diag:6.1.9.15: : :C: :PCIe2 10GbE Cu 4-port FCoE Adapter Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1060e214103e04:devices.pciex.df1060e214103e04.rte:6.1.9.15: : :C: :PCIe2 10Gb Cu 4-Port FCoE Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1060e214104104:devices.pciex.df1060e214104104.diag:6.1.9.15: : :C: :PCIe2 10Gb LR 4-Port FCoE Adapter Device Diagnostics : : : : : : :1:0:/:1415
devices.pciex.df1060e214104104:devices.pciex.df1060e214104104.rte:6.1.9.15: : :C: :PCIe2 10Gb LR 4-Port FCoE Adapter Device Software : : : : : : :1:0:/:1415
devices.pciex.df1060e214105204:devices.pciex.df1060e214105204.diag:6.1.8.0: : :C: :PCIe2 10GbE FCoE Mezz Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1060e214105204:devices.pciex.df1060e214105204.rte:6.1.9.0: : :C: :PCIe2 10Gb FCoE Mezzanine Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.df1060e214105f04:devices.pciex.df1060e214105f04.diag:6.1.8.1: : :C: :GX++ 10Gb FCoE Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.df1060e214105f04:devices.pciex.df1060e214105f04.rte:6.1.9.0: : :C: :GX++ 10Gb FCoE Adapter Device Software : : : : : : :1:0:/:1341
devices.pciex.e4143a161410a003:devices.pciex.e4143a161410a003.diag:6.1.6.0: : :C: :2-Port Gigabit Ethernet Combo PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1115
devices.pciex.e4143a161410a003:devices.pciex.e4143a161410a003.rte:6.1.6.0: : :C: :2-Port Gigabit Ethernet Combo PCI-Express Adapter Software : : : : : : :1:0:/:1115
devices.pciex.e4143a161410ed03:devices.pciex.e4143a161410ed03.diag:6.1.6.0: : :C: :2-Port Integrated Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1115
devices.pciex.e4143a161410ed03:devices.pciex.e4143a161410ed03.rte:6.1.6.0: : :C: :2-Port Integrated Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1115
devices.pciex.e4143a16e4140909:devices.pciex.e4143a16e4140909.diag:6.1.6.15: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1115
devices.pciex.e4143a16e4140909:devices.pciex.e4143a16e4140909.rte:6.1.7.0: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1140
devices.pciex.e4143a16e4143009:devices.pciex.e4143a16e4143009.diag:6.1.8.0: : :C: :4-Port Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.e4143a16e4143009:devices.pciex.e4143a16e4143009.rte:6.1.9.100: : :C: :4-Port Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1543
devices.pciex.e4145616e4140518:devices.pciex.e4145616e4140518.diag:6.1.9.100: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.e4145616e4140518:devices.pciex.e4145616e4140518.rte:6.1.9.100: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1543
devices.pciex.e4145616e4140528:devices.pciex.e4145616e4140528.diag:6.1.8.0: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1241
devices.pciex.e4145616e4140528:devices.pciex.e4145616e4140528.rte:6.1.9.100: : :C: :2-Port Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1543
devices.pciex.e414571614102004:devices.pciex.e414571614102004.diag:6.1.7.15: : :C: :4-Port Gigabit Ethernet PCI-Express Adapter Diagnostics : : : : : : :1:0:/:1216
devices.pciex.e414571614102004:devices.pciex.e414571614102004.rte:6.1.9.100: : :C: :4-Port Gigabit Ethernet PCI-Express Adapter Software : : : : : : :1:0:/:1543
devices.pciex.e4148a1614109304:devices.pciex.e4148a1614109304.diag:6.1.9.100: : :C: :PCIe2 4-Port (10GbE SFP+ & 1GbE RJ45) Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.e4148a1614109304:devices.pciex.e4148a1614109304.rte:6.1.9.100: : :C: :PCIe2 4-Port (10GbE SFP+ & 1GbE RJ45) Adapter : : : : : : :1:0:/:1543
devices.pciex.e4148a1614109404:devices.pciex.e4148a1614109404.diag:6.1.9.100: : :C: :PCIe2 4-Port (10GbE SFP+ & 1GbE RJ45) Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.e4148a1614109404:devices.pciex.e4148a1614109404.rte:6.1.9.100: : :C: :PCIe2 4-Port (10GbE SFP+ & 1GbE RJ45) Adapter : : : : : : :1:0:/:1543
devices.pciex.e4148e1614109204:devices.pciex.e4148e1614109204.diag:6.1.9.100: : :C: :PCIe2 2-Port 10GbE Base-T Adapter Diagnostics : : : : : : :1:0:/:1543
devices.pciex.e4148e1614109204:devices.pciex.e4148e1614109204.rte:6.1.9.100: : :C: :PCIe2 2-Port 10GbE Base-T Adapter : : : : : : :1:0:/:1543
devices.sas:devices.sas.diag:6.1.9.100: : :C: :Serial Attached SCSI Device Diagnostics : : : : : : :1:0:/:1543
devices.sas:devices.sas.rte:6.1.9.100: : :C: :Serial Attached SCSI Device Software : : : : : : :1:0:/:1543
devices.sata:devices.sata.diag:6.1.8.0: : :C: :Serial ATA Device Diagnostics : : : : : : :1:0:/:1241
devices.sata:devices.sata.rte:6.1.7.0: : :C: :Serial ATA Device Software : : : : : : :1:0:/:1140
devices.scsi.disk:devices.scsi.disk.diag.com:6.1.9.100: : :C: :Common Disk Diagnostic Service Aid : : : : : : :1:0:/:1543
devices.scsi.disk:devices.scsi.disk.diag.rte:6.1.9.100: : :C: :SCSI CD_ROM, Disk Device Diagnostics : : : : : : :1:0:/:1543
devices.scsi.disk:devices.scsi.disk.rspc:6.1.0.0: : :C: :RISC PC SCSI CD-ROM, Disk, Read/Write Optical Software : : : : : : :1:0:/:0747
devices.scsi.disk:devices.scsi.disk.rte:6.1.9.100: : :C: :SCSI CD-ROM, Disk, Read/Write Optical Device Software : : : : : : :1:0:/:1543
devices.scsi.safte:devices.scsi.safte.diag:6.1.0.0: : :C: :SCSI Accessed Fault-Tolerant Enclosure Device Diagnostics: : : : : : :1:0:/:0747
devices.scsi.safte:devices.scsi.safte.rte:6.1.0.0: : :C: :SCSI Accessed Fault-Tolerant Enclosure Device Software: : : : : : :1:0:/:0747
devices.scsi.ses:devices.scsi.ses.diag:6.1.9.100: : :C: :SCSI Enclosure Services Device Diagnostics : : : : : : :1:0:/:1543
devices.scsi.ses:devices.scsi.ses.rte:6.1.8.0: : :C: :SCSI Enclosure Device Software : : : : : : :1:0:/:1241
devices.scsi.tape:devices.scsi.tape.diag:6.1.7.15: : :C: :SCSI Tape Device Diagnostics : : : : : : :1:0:/:1216
devices.scsi.tape:devices.scsi.tape.rspc:6.1.0.0: : :C: :RISC PC SCSI Tape Device Software : : : : : : :1:0:/:0748
devices.scsi.tape:devices.scsi.tape.rte:6.1.9.100: : :C: :SCSI Tape Device Software : : : : : : :1:0:/:1543
devices.scsi.tm:devices.scsi.tm.rte:6.1.8.0: : :C: :SCSI Target Mode Software : : : : : : :1:0:/:1241
devices.serial.sb1:devices.serial.sb1.X11:6.1.4.0: : :C: :AIXwindows 6094-030 Spaceball 3-D Input Device Software : : : : : : :1:0:/:0943
devices.serial.tablet1:devices.serial.tablet1.X11:6.1.6.0: : :C: :AIXwindows Serial Tablet Input Device Software : : : : : : :1:0:/:1036
devices.tty:devices.tty.rte:6.1.9.100: : :C: :TTY Device Driver Support Software : : : : : : :1:0:/:1543
devices.usbif.010100:devices.usbif.010100.rte:6.1.9.15: : :C: :USB Audio Device Driver : : : : : : :1:0:/:1415
devices.usbif.03000008:devices.usbif.03000008.rte:6.1.9.15: : :C: :USB 3D Mouse Client Driver : : : : : : :1:0:/:1415
devices.usbif.030101:devices.usbif.030101.rte:6.1.9.15: : :C: :USB Keyboard Client Driver : : : : : : :1:0:/:1415
devices.usbif.030102:devices.usbif.030102.rte:6.1.9.15: : :C: :USB Mouse Client Driver : : : : : : :1:0:/:1415
devices.usbif.08025002:devices.usbif.08025002.diag:6.1.9.100: : :C: :USB Mass Storage Diagnostics : : : : : : :1:0:/:1543
devices.usbif.08025002:devices.usbif.08025002.rte:6.1.9.100: : :C: :USB Mass Storage Device Software : : : : : : :1:0:/:1543
devices.usbif.080400:devices.usbif.080400.diag:6.1.0.0: : :C: :USB Diskette Diagnostics : : : : : : :1:0:/:0747
devices.usbif.080400:devices.usbif.080400.rte:6.1.9.15: : :C: :USB Diskette Client Driver : : : : : : :1:0:/:1415
devices.vdevice.IBM.VASI-1:devices.vdevice.IBM.VASI-1.rte:6.1.9.101: : :C: :Virtual Asynchronous Services Interface (VASI) Software : : : : : : :0:0:/:1543
devices.vdevice.IBM.l-lan:devices.vdevice.IBM.l-lan.rte:6.1.9.100: : :C: :Virtual I/O Ethernet Software : : : : : : :1:0:/:1543
devices.vdevice.IBM.v-scsi-host:devices.vdevice.IBM.v-scsi-host.rte:6.1.9.100: : :C: :Virtual SCSI Server Adapter : : : : : : :0:0:/:1543
devices.vdevice.IBM.v-scsi:devices.vdevice.IBM.v-scsi.rte:6.1.9.100: : :C: :Virtual SCSI Client Support : : : : : : :1:0:/:1543
devices.vdevice.IBM.vfc-client:devices.vdevice.IBM.vfc-client.rte:6.1.9.101: : :C: :Virtual Fibre Channel Client Support : : : : : : :1:0:/:1543
devices.vdevice.IBM.vfc-server:devices.vdevice.IBM.vfc-server.rte:6.1.9.100: : :C: :Virtual Fibre Channel Server Adapter : : : : : : :0:0:/:1543
devices.vdevice.IBM.vmc:devices.vdevice.IBM.vmc.rte:6.1.8.0: : :C: :Virtual Management Channel : : : : : : :0:0:/:1241
devices.vdevice.IBM.vnic-server:devices.vdevice.IBM.vnic-server.rte:6.1.9.100: : :C: :Virtual NIC Server Device : : : : : : :0:0:/:1543
devices.vdevice.hvterm-protocol:devices.vdevice.hvterm-protocol.rte:6.1.0.0: : :C: :Virtual Terminal Physical Support: : : : : : :1:0:/:0747
devices.vdevice.hvterm1:devices.vdevice.hvterm1.rte:6.1.9.15: : :C: :Virtual Terminal Devices : : : : : : :1:0:/:1415
devices.vdevice.vbsd:devices.vdevice.vbsd.rte:6.1.9.100: : :C: :Virtual Block Storage Device : : : : : : :0:0:/:1543
devices.vdevice.vty-server:devices.vdevice.vty-server.rte:6.1.8.0: : :C: :Virtual Terminal Devices : : : : : : :1:0:/:1241
devices.vtdev.scsi:devices.vtdev.scsi.rte:6.1.9.101: : :C: :Virtual SCSI Target Devices : : : : : : :0:0:/:1543
dsm:dsm.core:6.1.9.100: : :C: :Distributed Systems Management Core : : : : : : :0:0:/:1543
dsm:dsm.dsh:6.1.9.100: : :C: :Distributed Systems Management Dsh : : : : : : :0:0:/:1543
expect.base:expect.base:5.42.1.0: : :C: :Binary executable files of Expect: : : : : : :0:0:/:
gsksa:gsksa.rte:7.0.4.50: : :C: :AIX Certificate and SSL Base Runtime ACME Toolkit: : : : : : :0:0:/:
gskta:gskta.rte:7.0.4.50: : :C: :AIX Certificate and SSL Base Runtime ACME Toolkit: : : : : : :0:0:/:
idsldap.clt32bit61:idsldap.clt32bit61.rte:6.1.0.57: : :C: :Directory Server - 32 bit Client: : : : : : :0:0:/:
idsldap.clt64bit61:idsldap.clt64bit61.rte:6.1.0.57: : :C: :Directory Server - 64 bit Client: : : : : : :0:0:/:
idsldap.cltbase61:idsldap.cltbase61.adt:6.1.0.57: : :C: :Directory Server - Base Client: : : : : : :0:0:/:
idsldap.cltbase61:idsldap.cltbase61.rte:6.1.0.57: : :C: :Directory Server - Base Client: : : : : : :0:0:/:
ifor_ls.base:ifor_ls.base.cli:6.1.0.0: : :C: :License Use Management Runtime Code: : : : : : :1:0:/:0747
ifor_ls.html.en_US:ifor_ls.html.en_US.base.cli:6.1.0.0: : :C: :LUM HTML Guides - U.S. English: : : : : : :1:0:/:0747
ifor_ls.msg.en_US:ifor_ls.msg.en_US.base.cli:6.1.0.0: : :C: :LUM Runtime Code Messages - U.S. English: : : : : : :1:0:/:0747
infocenter.man.EN_US.commands:infocenter.man.EN_US.commands:6.1.9.100: : :C: :AIX manual commands - U.S. English: : : : : : :0:0:/:
infocenter.man.EN_US.files:infocenter.man.EN_US.files:6.1.9.100: : :C: :AIX manual files - U.S. English: : : : : : :0:0:/:
infocenter.man.EN_US.libs:infocenter.man.EN_US.libs:6.1.9.100: : :C: :AIX manual libs - U.S. English: : : : : : :0:0:/:
infocenter.man.JA_JP.commands:infocenter.man.JA_JP.commands:6.1.9.30: : :C: :AIX manual commands - Japanese: : : : : : :0:0:/:
invscout.com:invscout.com:2.2.0.1: : :C: :Inventory Scout Microcode Catalog: : : : : : :1:0:/:
invscout.ivm:invscout.ivm.rte:2.2.0.2: : :C: :Inventory Scout IVM Runtime: : : : : : :0:0:/:
invscout.ldb:invscout.ldb:2.2.0.2: : :C: :Inventory Scout Logic Database: : : : : : :1:0:/:
invscout.msg.en_US:invscout.msg.en_US.rte:2.1.0.1: : :C: :Inventory Scout Messages - U.S. English: : : : : : :1:0:/:
invscout.rte:invscout.rte:2.2.0.20: : :C: :Inventory Scout Runtime: : : : : : :1:0:/:
ios.artex_profile:ios.artex_profile.rte:6.1.9.100: : :C: :Virtual I/O Server Default Settings : : : : : : :0:0:/:1543
ios.cli.man.ca_ES:ios.cli.man.ca_ES:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.en_US:ios.cli.man.en_US:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.es_ES:ios.cli.man.es_ES:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.fr_FR:ios.cli.man.fr_FR:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.it_IT:ios.cli.man.it_IT:6.1.8.15: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1316
ios.cli.man.ja_JP:ios.cli.man.ja_JP:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.pt_BR:ios.cli.man.pt_BR:6.1.9.100: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1543
ios.cli.man.pt_PT:ios.cli.man.pt_PT:6.1.8.15: : :C: :Virtual I/O Technologies Man Pages : : : : : : :0:0:/:1316
ios.cli:ios.cli.rte:6.1.9.100: : :C: :Virtual I/O Technologies : : : : : : :0:0:/:1543
ios.cli:ios.cli.smit:6.1.9.15: : :C: :IOSCLI SMIT Support : : : : : : :0:0:/:1415
ios.database:ios.database.rte:6.1.7.15: : :C: :VIOS DB : : : : : : :0:0:/:1216
ios.database:ios.database.solid:6.1.9.100: : :C: :VIOS DB : : : : : : :0:0:/:1543
ios.ldw:ios.ldw.gui:6.1.9.100: : :C: :LPAR Deployment Wizard Graphical User Interface : : : : : : :0:0:/:1543
ios.ldw:ios.ldw.rte:6.1.9.100: : :C: :LPAR Deployment Wizard Runtime : : : : : : :0:0:/:1543
ios.lparmgr.cim:ios.lparmgr.cim.rte:6.1.9.100: : :C: :IVM - CIM Providers : : : : : : :0:0:/:1543
ios.lparmgr.cli:ios.lparmgr.cli.rte:6.1.9.101: : :C: :Integrated Virtualization Manager : : : : : : :0:0:/:1543
ios.lparmgr.gui:ios.lparmgr.gui.base.rte:6.1.9.100: : :C: :IVM - Web Application : : : : : : :0:0:/:1543
ios.lparmgr.gui:ios.lparmgr.gui.httpd.rte:6.1.9.100: : :C: :IVM - Web Server : : : : : : :0:0:/:1543
ios.lparmgr.gui:ios.lparmgr.gui.nlv:6.1.9.45: : :C: :IVM - Web Application NLV : : : : : : :0:0:/:1524
ios.migration:ios.migration.rte:6.1.9.101: : :C: :LPAR Migration Support : : : : : : :0:0:/:1543
ios.paging:ios.paging.rte:6.1.9.100: : :C: :Virtual Real Memory Pager Support : : : : : : :0:0:/:1543
ios.sea:ios.sea:6.1.9.100: : :C: :Shared Ethernet Adapter : : : : : : :0:0:/:1543
ios.svm:ios.svm.rte:6.1.9.100: : :C: :Secure Virtual Machine : : : : : : :0:0:/:1543
ios.vlog:ios.vlog.rte:6.1.9.100: : :C: :Virtual Log Device Software : : : : : : :0:0:/:1543
ios.vnet:ios.vnet:6.1.9.100: : :C: :Virtual Network Management : : : : : : :0:0:/:1543
itm.cec:itm.cec.agent:6.2.7.0: : :C: :ITM CEC Agent: : : : : : :0:0:/:
itm.premium:itm.premium.rte:6.2.7.0: : :C: :ITM Runtime Install Files: : : : : : :0:0:/:
itm.vios_premium:itm.vios_premium.agent:6.2.7.0: : :C: :ITM VIOS Premium Agent: : : : : : :0:0:/:
ituam:ituam.rte:7.1.2.3: : :C: :ITUAM Runtime Install Files: : : : : : :0:0:/:
lum.base:lum.base.cli:5.1.2.0: : :C: :License Use Management Runtime Code: : : : : : :1:0:/:0747
lum.msg.en_US:lum.msg.en_US.base.cli:5.1.2.0: : :C: :LUM Runtime Code Messages - U.S. English: : : : : : :1:0:/:0747
lwi:lwi.runtime:6.1.9.100: : :C: :Lightweight Infrastructure Runtime : : : : : : :0:0:/:1543
mcr.rte:mcr.rte:6.1.9.100: : :C: :Metacluster Checkpoint and Restart : : : : : : :1:0:/:1543
ofed.core:ofed.core.rte:6.1.9.100: : :C: :OFED Core Runtime Environment : : : : : : :0:0:/:1543
openssh.base:openssh.base.client:6.0.0.6201: : :C: :Open Secure Shell Commands: : : : : : :0:0:/:
openssh.base:openssh.base.server:6.0.0.6201: : :C: :Open Secure Shell Server: : : : : : :0:0:/:
openssh.license:openssh.license:6.0.0.6201: : :C: :Open Secure Shell License: : : : : : :0:0:/:
openssh.man.en_US:openssh.man.en_US:6.0.0.6201: : :C: :Open Secure Shell Documentation - U.S. English: : : : : : :0:0:/:
openssh.msg.CA_ES:openssh.msg.CA_ES:6.0.0.6201: : :C: :Open Secure Shell Messages - Catalan (UTF): : : : : : :0:0:/:
openssh.msg.CS_CZ:openssh.msg.CS_CZ:6.0.0.6201: : :C: :Open Secure Shell Messages - Czech (UTF): : : : : : :0:0:/:
openssh.msg.DE_DE:openssh.msg.DE_DE:6.0.0.6201: : :C: :Open Secure Shell Messages - German (UTF): : : : : : :0:0:/:
openssh.msg.EN_US:openssh.msg.EN_US:6.0.0.6201: : :C: :Open Secure Shell Messages - U.S. English (UTF): : : : : : :0:0:/:
openssh.msg.ES_ES:openssh.msg.ES_ES:6.0.0.6201: : :C: :Open Secure Shell Messages - Spanish (UTF): : : : : : :0:0:/:
openssh.msg.FR_FR:openssh.msg.FR_FR:6.0.0.6201: : :C: :Open Secure Shell Messages - French (UTF): : : : : : :0:0:/:
openssh.msg.HU_HU:openssh.msg.HU_HU:6.0.0.6201: : :C: :Open Secure Shell Messages - Hungarian (UTF): : : : : : :0:0:/:
openssh.msg.IT_IT:openssh.msg.IT_IT:6.0.0.6201: : :C: :Open Secure Shell Messages - Italian (UTF): : : : : : :0:0:/:
openssh.msg.JA_JP:openssh.msg.JA_JP:6.0.0.6201: : :C: :Open Secure Shell Messages - Japanese (UTF): : : : : : :0:0:/:
openssh.msg.Ja_JP:openssh.msg.Ja_JP:6.0.0.6201: : :C: :Open Secure Shell Messages - Japanese: : : : : : :0:0:/:
openssh.msg.KO_KR:openssh.msg.KO_KR:6.0.0.6201: : :C: :Open Secure Shell Messages - Korean (UTF): : : : : : :0:0:/:
openssh.msg.PL_PL:openssh.msg.PL_PL:6.0.0.6201: : :C: :Open Secure Shell Messages - Polish (UTF): : : : : : :0:0:/:
openssh.msg.PT_BR:openssh.msg.PT_BR:6.0.0.6201: : :C: :Open Secure Shell Messages - Brazilian Portuguese (UTF): : : : : : :0:0:/:
openssh.msg.RU_RU:openssh.msg.RU_RU:6.0.0.6201: : :C: :Open Secure Shell Messages - Russian (UTF): : : : : : :0:0:/:
openssh.msg.SK_SK:openssh.msg.SK_SK:6.0.0.6201: : :C: :Open Secure Shell Messages - Slovak (UTF): : : : : : :0:0:/:
openssh.msg.ZH_CN:openssh.msg.ZH_CN:6.0.0.6201: : :C: :Open Secure Shell Messages - Simplified Chinese (UTF): : : : : : :0:0:/:
openssh.msg.ZH_TW:openssh.msg.ZH_TW:6.0.0.6201: : :C: :Open Secure Shell Messages - Traditional Chinese (UTF): : : : : : :0:0:/:
openssh.msg.Zh_CN:openssh.msg.Zh_CN:6.0.0.6201: : :C: :Open Secure Shell Messages - Simplified Chinese (GBK): : : : : : :0:0:/:
openssh.msg.Zh_TW:openssh.msg.Zh_TW:6.0.0.6201: : :C: :Open Secure Shell Messages - Traditional Chinese (big5): : : : : : :0:0:/:
openssh.msg.ca_ES:openssh.msg.ca_ES:6.0.0.6201: : :C: :Open Secure Shell Messages - Catalan: : : : : : :0:0:/:
openssh.msg.cs_CZ:openssh.msg.cs_CZ:6.0.0.6201: : :C: :Open Secure Shell Messages - Czech: : : : : : :0:0:/:
openssh.msg.de_DE:openssh.msg.de_DE:6.0.0.6201: : :C: :Open Secure Shell Messages - German: : : : : : :0:0:/:
openssh.msg.en_US:openssh.msg.en_US:6.0.0.6201: : :C: :Open Secure Shell Messages - U.S. English: : : : : : :0:0:/:
openssh.msg.es_ES:openssh.msg.es_ES:6.0.0.6201: : :C: :Open Secure Shell Messages - Spanish: : : : : : :0:0:/:
openssh.msg.fr_FR:openssh.msg.fr_FR:6.0.0.6201: : :C: :Open Secure Shell Messages - French: : : : : : :0:0:/:
openssh.msg.hu_HU:openssh.msg.hu_HU:6.0.0.6201: : :C: :Open Secure Shell Messages - Hungarian: : : : : : :0:0:/:
openssh.msg.it_IT:openssh.msg.it_IT:6.0.0.6201: : :C: :Open Secure Shell Messages - Italian: : : : : : :0:0:/:
openssh.msg.ja_JP:openssh.msg.ja_JP:6.0.0.6201: : :C: :Open Secure Shell Messages - Japanese IBM-eucJP: : : : : : :0:0:/:
openssh.msg.ko_KR:openssh.msg.ko_KR:6.0.0.6201: : :C: :Open Secure Shell Messages - Korean: : : : : : :0:0:/:
openssh.msg.pl_PL:openssh.msg.pl_PL:6.0.0.6201: : :C: :Open Secure Shell Messages - Polish: : : : : : :0:0:/:
openssh.msg.pt_BR:openssh.msg.pt_BR:6.0.0.6201: : :C: :Open Secure Shell Messages - Brazilian Portuguese: : : : : : :0:0:/:
openssh.msg.ru_RU:openssh.msg.ru_RU:6.0.0.6201: : :C: :Open Secure Shell Messages - Russian: : : : : : :0:0:/:
openssh.msg.sk_SK:openssh.msg.sk_SK:6.0.0.6201: : :C: :Open Secure Shell Messages - Slovak: : : : : : :0:0:/:
openssh.msg.zh_CN:openssh.msg.zh_CN:6.0.0.6201: : :C: :Open Secure Shell Messages - Simplified Chinese: : : : : : :0:0:/:
openssh.msg.zh_TW:openssh.msg.zh_TW:6.0.0.6201: : :C: :Open Secure Shell Messages - Traditional Chinese: : : : : : :0:0:/:
openssl.base:openssl.base:1.0.1.515: : :C: :Open Secure Socket Layer: : : : : : :0:0:/:
openssl.license:openssl.license:1.0.1.515: : :C: :Open Secure Socket License: : : : : : :0:0:/:
openssl.man.en_US:openssl.man.en_US:1.0.1.515: : :C: :Open Secure Socket Layer: : : : : : :0:0:/:
perf.analysis:perf.analysis:1.2.0.2: : :C: :Local Performance Analysis Tools: : : : : : :0:0:/:
perfagent.server:perfagent.server:6.1.9.15: : :C: :Performance Agent Daemons & Utilities : : : : : : :0:0:/:1415
perfagent.tools:perfagent.tools:6.1.9.100: : :C: :Local Performance Analysis & Control Commands : : : : : : :1:0:/:1543
perl.libext:perl.libext:2.2.8.0: : :C: :Perl Library Extensions : : : : : : :1:0:/:1241
perl.rte:perl.rte:5.8.8.488: : :C: :Perl Version 5 Runtime Environment: : : : : : :1:0:/:1241
pool.basic:pool.basic.diag:6.1.9.100: : :C: :Virtual Server Storage Subsystem Diagnostics : : : : : : :0:0:/:1543
pool.basic:pool.basic.rte:6.1.9.100: : :C: :Virtual Server Storage Subsystem Runtime : : : : : : :0:0:/:1543
pool.msg.en_US:pool.msg.en_US.basic.rte:6.1.7.0: : :C: :Virtual Server Storage Subsystem Messages - English : : : : : : :0:0:/:1140
powerscExp.ice:powerscExp.ice.cmds:1.1.3.0: : :C: :ICE Express Security Extension: : : : : : :0:0:/:
powerscExp.license:powerscExp.license:1.1.3.0: : :C: :PowerSC Express Edition: : : : : : :0:0:/:
printers.msg.en_US:printers.msg.en_US.rte:6.1.4.0: : :C: :Printer Backend Messages - U.S. English : : : : : : :1:0:/:0943
printers.rte:printers.rte:6.1.9.100: : :C: :Printer Backend : : : : : : :1:0:/:1543
rpm.rte:rpm.rte:3.0.5.52: : :C: :RPM Package Manager: : : : : : :1:0:/:
rsct.basic:rsct.basic.hacmp:3.2.0.2: : :C:F:RSCT Basic Function (HACMP/ES Support): : : : : : :0:0:/:
rsct.basic:rsct.basic.rte:3.2.0.7: : :C:F:RSCT Basic Function: : : : : : :0:0:/:
rsct.basic:rsct.basic.sp:3.2.0.0: : :C: :RSCT Basic Function (PSSP Support): : : : : : :0:0:/:
rsct.compat.basic:rsct.compat.basic.hacmp:3.2.0.0: : :C: :RSCT Event Management Basic Function (HACMP/ES Support): : : : : : :0:0:/:
rsct.compat.basic:rsct.compat.basic.rte:3.2.0.0: : :C: :RSCT Event Management Basic Function: : : : : : :0:0:/:
rsct.compat.basic:rsct.compat.basic.sp:3.2.0.0: : :C: :RSCT Event Management Basic Function (PSSP Support): : : : : : :0:0:/:
rsct.compat.clients:rsct.compat.clients.hacmp:3.2.0.0: : :C: :RSCT Event Management Client Function (HACMP/ES Support): : : : : : :0:0:/:
rsct.compat.clients:rsct.compat.clients.rte:3.2.0.0: : :C: :RSCT Event Management Client Function: : : : : : :0:0:/:
rsct.compat.clients:rsct.compat.clients.sp:3.2.0.1: : :C:F:RSCT Event Management Client Function (PSSP Support): : : : : : :0:0:/:
rsct.core:rsct.core.auditrm:3.2.0.0: : :C: :RSCT Audit Log Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.errm:3.2.0.2: : :C:F:RSCT Event Response Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.fsrm:3.2.0.1: : :C:F:RSCT File System Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.gui:3.2.0.0: : :C: :RSCT Graphical User Interface: : : : : : :1:0:/:
rsct.core:rsct.core.hostrm:3.2.0.2: : :C:F:RSCT Host Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.lprm:3.2.0.2: : :C:F:RSCT Least Privilege Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.microsensor:3.2.0.0: : :C: :RSCT MicroSensor Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.rmc:3.2.0.9: : :C:F:RSCT Resource Monitoring and Control: : : : : : :1:0:/:
rsct.core:rsct.core.sec:3.2.0.2: : :C:F:RSCT Security: : : : : : :1:0:/:
rsct.core:rsct.core.sensorrm:3.2.0.1: : :C:F:RSCT Sensor Resource Manager: : : : : : :1:0:/:
rsct.core:rsct.core.sr:3.2.0.4: : :C:F:RSCT Registry: : : : : : :1:0:/:
rsct.core:rsct.core.utils:3.2.0.10: : :C:F:RSCT Utilities: : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.auditrm:2.5.4.0: : :C: :RSCT Audit Log RM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.errm:2.5.4.0: : :C: :RSCT Event Response RM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.fsrm:2.5.4.0: : :C: :RSCT File System RM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.gui:2.5.4.0: : :C: :RSCT GUI Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.hostrm:2.5.4.0: : :C: :RSCT Host RM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.lprm:2.5.4.0: : :C: :RSCT LPRM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.rmc:2.5.4.0: : :C: :RSCT RMC Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.sec:2.5.4.0: : :C: :RSCT Security Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.sensorrm:2.5.4.0: : :C: :RSCT Sensor RM Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.sr:2.5.4.0: : :C: :RSCT Registry Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.EN_US:rsct.msg.EN_US.core.utils:2.5.4.0: : :C: :RSCT Utilities Msgs - U.S. English (UTF): : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.auditrm:2.5.4.0: : :C: :RSCT Audit Log RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.errm:2.5.4.0: : :C: :RSCT Event Response RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.fsrm:2.5.4.0: : :C: :RSCT File System RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.gui:2.5.4.0: : :C: :RSCT GUI Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.gui.com:2.5.4.0: : :C: :RSCT GUI JAVA Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.hostrm:2.5.4.0: : :C: :RSCT Host RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.lprm:2.5.4.0: : :C: :RSCT LPRM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.microsensorrm:2.5.4.0: : :C: :RSCT MicorSensor RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.rmc:2.5.4.0: : :C: :RSCT RMC Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.rmc.com:2.5.4.0: : :C: :RSCT RMC JAVA Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.sec:2.5.4.0: : :C: :RSCT Security Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.sensorrm:2.5.4.0: : :C: :RSCT Sensor RM Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.sr:2.5.4.0: : :C: :RSCT Registry Msgs - U.S. English: : : : : : :1:0:/:
rsct.msg.en_US:rsct.msg.en_US.core.utils:2.5.4.0: : :C: :RSCT Utilities Msgs - U.S. English: : : : : : :1:0:/:
rsct.opt.fence:rsct.opt.fence.blade:3.2.0.0: : :C: :RSCT BLADE Fence Agent: : : : : : :0:0:/:
rsct.opt.fence:rsct.opt.fence.hmc:3.2.0.0: : :C: :RSCT Fence Agent: : : : : : :0:0:/:
rsct.opt.stackdump:rsct.opt.stackdump:3.2.0.2: : :C:F:RSCT Stackdump module: : : : : : :0:0:/:
rsct.opt.storagerm:rsct.opt.storagerm:3.2.0.5: : :C:F:RSCT Storage Resource Manager: : : : : : :0:0:/:
security.acf:security.acf:6.1.9.100: : :C: :ACF/PKCS11 Device Driver : : : : : : :1:0:/:1543
sysmgt.cim.providers:sysmgt.cim.providers.metrics:2.12.1.1: : :C: :Metrics Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.providers:sysmgt.cim.providers.osbase:2.12.1.1: : :C: :Base Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.providers:sysmgt.cim.providers.scc:2.12.1.1: : :C: :Security Control Compliance Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.providers:sysmgt.cim.providers.smash:2.12.1.1: : :C: :Smash Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.smisproviders:sysmgt.cim.smisproviders.hba_hdr:2.12.1.1: : :C: :SMI-S HBA&HDR Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.smisproviders:sysmgt.cim.smisproviders.hhr:2.12.1.1: : :C: :SMI-S HHR Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cim.smisproviders:sysmgt.cim.smisproviders.vblksrv:2.12.1.1: : :C: :SMI-S Storage Virtualizer Providers for AIX OS: : : : : : :0:0:/:
sysmgt.cimserver.pegasus:sysmgt.cimserver.pegasus.rte:2.12.1.1: : :C: :Pegasus CIM Server Runtime Environment: : : : : : :0:0:/:
sysmgt.sguide:sysmgt.sguide.rte:6.1.9.100: : :C: :TaskGuide Runtime Environment : : : : : : :0:0:/:1543
sysmgt.websm:sysmgt.websm.apps:6.1.9.100: : :C: :Web-based System Manager Applications : : : : : : :0:0:/:1543
sysmgt.websm:sysmgt.websm.framework:6.1.9.100: : :C: :Web-based System Manager Client/Server Support : : : : : : :0:0:/:1543
sysmgt.websm:sysmgt.websm.icons:6.1.9.100: : :C: :Web-based System Manager Icons : : : : : : :0:0:/:1543
sysmgt.websm:sysmgt.websm.rte:6.1.9.100: : :C: :Web-based System Manager Runtime Environment : : : : : : :0:0:/:1543
sysmgtlib.framework:sysmgtlib.framework.core:6.1.9.100: : :C: :System Management Service Libraries Common Code : : : : : : :0:0:/:1543
tcl.base:tcl.base:8.4.7.0: : :C: :Binary executable files of Tcl: : : : : : :0:0:/:
tivoli.tivguid:tivoli.tivguid:1.3.4.1: : :C: :IBM Tivoli GUID on AIX: : : : : : :0:0:/:
tivoli.tsm.client.api.32bit:tivoli.tsm.client.api.32bit:6.1.0.0: : :C: :TSM Client - Application Programming Interface: : : : : : :0:0:/:
tivoli.tsm.client.api.64bit:tivoli.tsm.client.api.64bit:6.1.0.0: : :C: :TSM Client - 64bit Application Programming Interface: : : : : : :0:0:/:
tivoli.tsm.client.ba:tivoli.tsm.client.ba.32bit.base:6.1.0.0: : :C: :TSM Client - Backup/Archive Base Files: : : : : : :0:0:/:
tivoli.tsm.client.ba:tivoli.tsm.client.ba.32bit.common:6.1.0.0: : :C: :TSM Client - Backup/Archive Common Files: : : : : : :0:0:/:
tivoli.tsm.client.ba:tivoli.tsm.client.ba.32bit.image:6.1.0.0: : :C: :TSM Client - IMAGE Backup Client: : : : : : :0:0:/:
tivoli.tsm.client.ba:tivoli.tsm.client.ba.32bit.nas:6.1.0.0: : :C: :TSM Client - NAS Backup Client: : : : : : :0:0:/:
tivoli.tsm.client.ba:tivoli.tsm.client.ba.32bit.web:6.1.0.0: : :C: :TSM Client - Backup/Archive WEB Client: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.CS_CZ:6.1.0.0: : :C: :TSM Client Messages - Czech: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.DE_DE:6.1.0.0: : :C: :TSM Client Messages - German: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.ES_ES:6.1.0.0: : :C: :TSM Client Messages - Spanish: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.FR_FR:6.1.0.0: : :C: :TSM Client Messages - French: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.HU_HU:6.1.0.0: : :C: :TSM Client Messages - Hungarian: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.IT_IT:6.1.0.0: : :C: :TSM Client Messages - Italian: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.JA_JP:6.1.0.0: : :C: :TSM Client Messages - Japanese: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.KO_KR:6.1.0.0: : :C: :TSM Client Messages - Korean: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.PL_PL:6.1.0.0: : :C: :TSM Client Messages - Polish: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.PT_BR:6.1.0.0: : :C: :TSM Client Messages - Portuguese: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.RU_RU:6.1.0.0: : :C: :TSM Client Messages - Russian: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.ZH_CN:6.1.0.0: : :C: :TSM Client Messages - Chinese Simplified: : : : : : :0:0:/:
tivoli.tsm.client.msg:tivoli.tsm.client.msg.ZH_TW:6.1.0.0: : :C: :TSM Client Messages - Chinese Traditional: : : : : : :0:0:/:
tk.base:tk.base:8.4.7.0: : :C: :Binary executable files of Tk: : : : : : :0:0:/:
udapl:udapl.rte:6.1.9.100: : :C: :uDAPL : : : : : : :0:0:/:1543
vios.agent:vios.agent.rte:6.3.0.0: : :C: :VIOS Cluster CAS sub-agent: : : : : : :0:0:/:
wio.common:wio.common:6.1.8.0: : :C: :Common I/O Support for Workload Partitions : : : : : : :1:0:/:1241
wio.fcp:wio.fcp:6.1.9.100: : :C: :FC I/O Support for Workload Partitions : : : : : : :1:0:/:1543
wio.vscsi:wio.vscsi:6.1.7.0: : :C: :VSCSI I/O Support for Workload Partitions : : : : : : :1:0:/:1140
xlC.aix61:xlC.aix61.rte:13.1.2.0: : :C: :IBM XL C++ Runtime for AIX 6.1 and 7.1: : : : : : :1:0:/:
xlC.cpp:xlC.cpp:9.0.0.0: : :C: :C for AIX Preprocessor: : : : : : :1:0:/:
xlC.msg.Ja_JP:xlC.msg.Ja_JP.rte:13.1.2.0: : :C: :IBM XL C++ Runtime Messages--Japanese: : : : : : :0:0:/:
xlC.msg.en_US.cpp:xlC.msg.en_US.cpp:9.0.0.0: : :C: :C for AIX Preprocessor Messages--U.S. English: : : : : : :1:0:/:
xlC.msg.en_US:xlC.msg.en_US.rte:13.1.2.0: : :C: :IBM XL C++ Runtime Messages--U.S. English: : : : : : :1:0:/:
xlC.msg.ja_JP:xlC.msg.ja_JP.rte:13.1.2.0: : :C: :IBM XL C++ Runtime Messages--Japanese IBM-eucJP: : : : : : :0:0:/:
xlC.rte:xlC.rte:13.1.2.0: : :C: :IBM XL C++ Runtime for AIX : : : : : : :1:0:/:
xlC.sup.aix50.rte:xlC.sup.aix50.rte:9.0.0.1: : :C: :XL C/C++ Runtime for AIX 5.2: : : : : : :1:0:/:
xlsmp.aix61.rte:xlsmp.aix61.rte:4.1.2.0: : :C: :SMP Runtime Libraries: : : : : : :0:0:/:
xlsmp.msg.EN_US.rte:xlsmp.msg.EN_US.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - U.S. English UTF-8: : : : : : :0:0:/:
xlsmp.msg.Ja_JP.rte:xlsmp.msg.Ja_JP.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - Japanese: : : : : : :0:0:/:
xlsmp.msg.ZH_CN.rte:xlsmp.msg.ZH_CN.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - Simplified Chinese UTF-8: : : : : : :0:0:/:
xlsmp.msg.Zh_CN.rte:xlsmp.msg.Zh_CN.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - Simplified Chinese: : : : : : :0:0:/:
xlsmp.msg.en_US.rte:xlsmp.msg.en_US.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - U.S. English: : : : : : :0:0:/:
xlsmp.msg.ja_JP.rte:xlsmp.msg.ja_JP.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - Japanese IBM-eucJP: : : : : : :0:0:/:
xlsmp.msg.zh_CN.rte:xlsmp.msg.zh_CN.rte:4.1.2.0: : :C: :XL SMP Runtime Messages - Simplified Chinese IBM-eucCN: : : : : : :0:0:/:
xlsmp.rte:xlsmp.rte:4.1.2.0: : :C: :SMP Runtime Library : : : : : : :0:0:/:
AIX-rpm:AIX-rpm-6.1.9.100-5:6.1.9.100-5: : :C:R:Virtual Package for libraries and shells installed on system: :/bin/rpm -e AIX-rpm: : : : :1: :(none):Sun Mar 20 15:55:35 CDT 2016
cdrecord:cdrecord-1.9-9:1.9-9: : :C:R:A command line CD/DVD recording program.: :/bin/rpm -e cdrecord: : : : :1: :/opt/freeware:Thu Mar 31 05:41:05 CDT 2011
mkisofs:mkisofs-1.13-9:1.13-9: : :C:R:Creates an image of an ISO9660 filesystem.: :/bin/rpm -e mkisofs: : : : :1: :/opt/freeware:Thu Mar 31 05:41:05 CDT 2011
osinstall:osinstall-1.6-1:1.6-1: : :C:R:Cross-platform network installer of multiple operating systems.: :/bin/rpm -e osinstall: : : : :0: :(none):Fri Aug 19 12:00:32 CDT 2011
pci.14101103:pci.14101103-CN0120-1:CN0120-1: : :C:R:Microcode for 4-Port 10/100/1000 Base-TX PCI-X Adapter: :/bin/rpm -e pci.14101103: : : : :0: :/etc/microcode:Wed Aug 20 14:55:50 CDT 2008"


    string.each_line do  |line|
      package = Package.new(line)
    end




  end

end