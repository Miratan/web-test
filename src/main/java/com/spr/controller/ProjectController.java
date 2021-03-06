package com.spr.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.spr.exception.ProjectNotFound;
import com.spr.model.Note;
import com.spr.model.Permission;
import com.spr.model.Project;
import com.spr.model.User;
import com.spr.modelGeneric.ProjectView;
import com.spr.modelGeneric.ProjectWithPermission;
import com.spr.repository.ProjectRepository;
import com.spr.service.NoteService;
import com.spr.service.PermissionService;
import com.spr.service.ProjectService;
import com.spr.service.UserService;
import com.spr.session.UserSession;

@Controller
@SessionAttributes("login")
@RequestMapping("/project")
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private UserSession userSession;
	
	@Autowired
	private ProjectRepository projectRepository;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PermissionService permissionService;
	
	@Autowired
	private NoteService noteService;
	
	@RequestMapping(value="/create", method = RequestMethod.POST)
	public @ResponseBody ModelAndView createProject(@ModelAttribute Project project){
		projectService.create(project);
		
		
		ModelAndView mav = new ModelAndView("indexUser");
		mav.addObject("msg", "Projeto criado com sucesso!");
		mav.setViewName("indexUser");
		return mav;
	}
	
	@RequestMapping(value="/update", method = RequestMethod.POST)
	public @ResponseBody String updateProject(
			@RequestParam(value="id", required=true) Integer id,
			@RequestParam(value="description", required=false) String description,
			@RequestParam(value="keyWords", required=false) String keyWords,
			@RequestParam(value="discipline", required=false) String discipline,
			@RequestParam(value="name", required=false) String name,
			@RequestParam(value="deliveryDate", required=false) Date deliveryDate
		){
		
		Project project =  new Project();
		project.setDeliveryDate(deliveryDate);
		project.setDescription(description);
		project.setDiscipline(discipline);
		project.setKeyWords(keyWords);
		project.setTitle(name);
		project.setProjectId(id);
		
		try {
			projectService.update(project);
		} catch (ProjectNotFound e) {
			e.printStackTrace();
		}
		
		
		return "Projeto Atualizado com Sucesso";
	}
	
	@RequestMapping(value="/findUserLogged", method = RequestMethod.GET)
	public @ResponseBody List<Project> getProjectUserLogged(){
		User user = userService.findById(userSession.getUserLogado().getUserId());
		return (List<Project>) projectService.findAllByUserId(user.getUserId());
	}
	
	@RequestMapping(value = "/allProject", method = RequestMethod.GET)
	public @ResponseBody List<Project> allProject() {
		User user = userService.findById(userSession.getUserLogado().getUserId());
		return projectRepository.findByUserId(user.getUserId());
	}
	
	@RequestMapping(value="/deleteProject/{projectId}", method = RequestMethod.DELETE)
	public @ResponseBody List<Project> deleProjectGetProjects(@PathVariable Integer projectId){
		
		try {
			projectService.delete(projectId);
		} catch (ProjectNotFound e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		User user = userService.findById(userSession.getUserLogado().getUserId());
		return (List<Project>) projectService.findAllByUserId(user.getUserId());
	}
	
	@RequestMapping(value="/findById/{id}", method = RequestMethod.GET)
	public @ResponseBody Project getProjectById(@PathVariable Integer id){
		return projectService.findById(id);
	}
	
	@RequestMapping(value="/createNote", method = RequestMethod.POST)
	public @ResponseBody Note createNote(
			@RequestParam(value="description", required=false) String description,
			@RequestParam(value="projectId", required=false) Integer projectId,
			@RequestParam(value="date", required=false) Date date){
		Note note = new Note();
		note.setDescription(description);
		note.setDateCreated(getCurrentDate());
		note.setProject(projectService.findById(projectId));
		return noteService.create(note);
	}
	
	@RequestMapping(value="/searchNotes/{id}", method = RequestMethod.GET)
	public @ResponseBody List<Note> getNotesById(@PathVariable Integer id){
		return noteService.findByProjectId(id);
	}
	
	@RequestMapping(value="/permission/{id}/{userId}", method = RequestMethod.GET)
	public @ResponseBody Permission getPermission(@PathVariable Integer id,
			@PathVariable Integer userId){
		if(userId == -10){
			userId = userSession.getUserLogado().getUserId();
		}
		return permissionService.findPermission(id, userId);
	}
	
	public String getCurrentDate(){
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy/MM/dd");
		java.util.Date date = new java.util.Date();
		String today = dateFormat.format(date);
		String dt[] = today.split("/");
		String ano = dt[0];
		String mes = dt[1];
		String dia = dt[2];
		return dia+"/"+mes+"/"+ano;
	}
	
	@RequestMapping(value = "/collaborativeProjects", method = RequestMethod.GET)
	public @ResponseBody List<ProjectWithPermission> getCollaborativeProjects(){
		List<Project> p = projectService.collaborativeProjects(userSession.getUserLogado().getUserId());
		return permissionService.permissionInProject(p);
	}
	
	@RequestMapping(value = "/viewProjectInfo/{id}", method = RequestMethod.GET)
	public @ResponseBody List<ProjectView> getProjectInfo(@PathVariable Integer id){
		Project p = projectService.findById(id);
		return projectService.infoProject(p);
	}
	
}
