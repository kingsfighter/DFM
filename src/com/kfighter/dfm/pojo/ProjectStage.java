package com.kfighter.dfm.pojo;

public class ProjectStage {
	private int id ;
	private String stageName;
	private int stageOrder;
	private String statrTime;
	private String endTime;
	private int projectId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStageName() {
		return stageName;
	}
	public void setStageName(String stageName) {
		this.stageName = stageName;
	}

	public int getStageOrder() {
		return stageOrder;
	}
	public void setStageOrder(int stageOrder) {
		this.stageOrder = stageOrder;
	}
	public String getStatrTime() {
		return statrTime;
	}
	public void setStatrTime(String statrTime) {
		this.statrTime = statrTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	
	
	
}
