package com.spr.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

@Entity
@Table
public class Project implements Serializable {

	private static final long serialVersionUID = -4091038843674636286L;

	@Id
	@GeneratedValue
	private Integer projectId;
	
	@Column(length=200)
	private String title;
	
	@Column(length=3000)
	private String description;
	
	@Column(length=60)
	private String keyWords;
	
	@Column(length=30)
	private String discipline;
	
	private Date deliveryDate;
	
	@Column(columnDefinition = "int(2) DEFAULT 0", insertable = false, updatable = true)
	private Integer version;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="userId")
	private User user;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy="project", targetEntity = Note.class)
	@Cascade({CascadeType.SAVE_UPDATE})
	private List<Note> note;
	
	@OneToMany(mappedBy = "project", fetch = FetchType.LAZY, targetEntity = Permission.class)
	private List<Permission> permission;

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeyWords() {
		return keyWords;
	}

	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}

	public String getDiscipline() {
		return discipline;
	}

	public void setDiscipline(String discipline) {
		this.discipline = discipline;
	}

	public Date getDeliveryDate() {
		return deliveryDate;
	}

	public void setDeliveryDate(Date deliveryDate) {
		this.deliveryDate = deliveryDate;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

}
