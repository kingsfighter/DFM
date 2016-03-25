package com.kfighter.dfm.pojo;

public class Project
{
  private int id;
  private String projectName;
  private int version = 1;
  private int pcbFile;
  private int bomFile;
  private String pcbFileName;
  private String bomFileName;
  private int checkType;
  private String checkTypeStr;
  private String dfmCheck;
  private int pcbType;
  private int hdiModel;
  private float boardThickness;
  private int panelModel;
  private float maxHeightTop;
  private int subPcbNum;
  private float maxHeightBot;
  private int railwayPosition;
  private int viacapLayer;
  private int assemblyProcessTop;
  private int havePb;
  private int assemblyProcessBot;
  private int surfaceProcess;
  private int directionTop;
  private int primarySide;
  private int directionBot;
  private int directionBotFs;
  private String density;
  private int submitUser;
  private String submitUserName;
  private String submitTime;
  private String endTime;
  private String state = "待查";
  private int taskNum = 0;
  private int pri = 1;
  private String resultFile = "";
  private String server = "";
  private String serverState = "";
  private String runTime = "-";

  public String getRunTime() {
    return this.runTime; }

  public void setRunTime(String runTime) {
    this.runTime = runTime; }

  public String getProjectName() {
    return this.projectName; }

  public void setProjectName(String projectName) {
    this.projectName = projectName; }

  public int getVersion() {
    return this.version; }

  public void setVersion(int version) {
    this.version = version; }

  public int getPcbFile() {
    return this.pcbFile; }

  public void setPcbFile(int pcbFile) {
    this.pcbFile = pcbFile; }

  public int getBomFile() {
    return this.bomFile; }

  public void setBomFile(int bomFile) {
    this.bomFile = bomFile; }

  public int getCheckType() {
    return this.checkType; }

  public void setCheckType(int checkType) {
    this.checkType = checkType; }

  public String getDfmCheck() {
    return this.dfmCheck; }

  public void setDfmCheck(String dfmCheck) {
    this.dfmCheck = dfmCheck; }

  public int getPcbType() {
    return this.pcbType; }

  public void setPcbType(int pcbType) {
    this.pcbType = pcbType; }

  public int getHdiModel() {
    return this.hdiModel; }

  public void setHdiModel(int hdiModel) {
    this.hdiModel = hdiModel; }

  public float getBoardThickness() {
    return this.boardThickness; }

  public void setBoardThickness(float boardThickness) {
    this.boardThickness = boardThickness; }

  public int getPanelModel() {
    return this.panelModel; }

  public void setPanelModel(int panelModel) {
    this.panelModel = panelModel; }

  public float getMaxHeightTop() {
    return this.maxHeightTop; }

  public void setMaxHeightTop(float maxHeightTop) {
    this.maxHeightTop = maxHeightTop; }

  public int getSubPcbNum() {
    return this.subPcbNum; }

  public void setSubPcbNum(int subPcbNum) {
    this.subPcbNum = subPcbNum; }

  public float getMaxHeightBot() {
    return this.maxHeightBot; }

  public void setMaxHeightBot(float maxHeightBot) {
    this.maxHeightBot = maxHeightBot; }

  public int getRailwayPosition() {
    return this.railwayPosition; }

  public void setRailwayPosition(int railwayPosition) {
    this.railwayPosition = railwayPosition; }

  public int getViacapLayer() {
    return this.viacapLayer; }

  public void setViacapLayer(int viacapLayer) {
    this.viacapLayer = viacapLayer; }

  public int getAssemblyProcessTop() {
    return this.assemblyProcessTop; }

  public void setAssemblyProcessTop(int assemblyProcessTop) {
    this.assemblyProcessTop = assemblyProcessTop; }

  public int getHavePb() {
    return this.havePb; }

  public void setHavePb(int havePb) {
    this.havePb = havePb; }

  public int getAssemblyProcessBot() {
    return this.assemblyProcessBot; }

  public void setAssemblyProcessBot(int assemblyProcessBot) {
    this.assemblyProcessBot = assemblyProcessBot; }

  public int getSurfaceProcess() {
    return this.surfaceProcess; }

  public void setSurfaceProcess(int surfaceProcess) {
    this.surfaceProcess = surfaceProcess; }

  public int getDirectionTop() {
    return this.directionTop; }

  public void setDirectionTop(int directionTop) {
    this.directionTop = directionTop; }

  public int getPrimarySide() {
    return this.primarySide; }

  public void setPrimarySide(int primarySide) {
    this.primarySide = primarySide; }

  public int getDirectionBot() {
    return this.directionBot; }

  public void setDirectionBot(int directionBot) {
    this.directionBot = directionBot; }

  public int getSubmitUser() {
    return this.submitUser; }

  public void setSubmitUser(int submitUser) {
    this.submitUser = submitUser; }

  public String getSubmitTime() {
    return this.submitTime; }

  public void setSubmitTime(String submitTime) {
    this.submitTime = submitTime; }

  public String getState() {
    return this.state; }

  public void setState(String state) {
    this.state = state; }

  public int getTaskNum() {
    return this.taskNum; }

  public void setTaskNum(int taskNum) {
    this.taskNum = taskNum; }

  public int getPri() {
    return this.pri; }

  public void setPri(int pri) {
    this.pri = pri; }

  public String getResultFile() {
    return this.resultFile; }

  public void setResultFile(String resultFile) {
    this.resultFile = resultFile; }

  public String getServer() {
    return this.server; }

  public void setServer(String server) {
    this.server = server; }

  public String getServerState() {
    return this.serverState; }

  public void setServerState(String serverState) {
    this.serverState = serverState; }

  public String getPcbFileName() {
    return this.pcbFileName; }

  public void setPcbFileName(String pcbFileName) {
    this.pcbFileName = pcbFileName; }

  public String getBomFileName() {
    return this.bomFileName; }

  public void setBomFileName(String bomFileName) {
    this.bomFileName = bomFileName; }

  public int getId() {
    return this.id; }

  public void setId(int id) {
    this.id = id; }

  public String getSubmitUserName() {
    return this.submitUserName; }

  public void setSubmitUserName(String submitUserName) {
    this.submitUserName = submitUserName; }

  public String getEndTime() {
    return this.endTime; }

  public void setEndTime(String endTime) {
    this.endTime = endTime; }

  public String getCheckTypeStr() {
    return this.checkTypeStr; }

  public void setCheckTypeStr(String checkTypeStr) {
    this.checkTypeStr = checkTypeStr; }

  public int getDirectionBotFs() {
    return this.directionBotFs; }

  public void setDirectionBotFs(int directionBotFs) {
    this.directionBotFs = directionBotFs;
  }

  public String getDensity() {
    return this.density; }

  public void setDensity(String density) {
    this.density = density;
  }
}