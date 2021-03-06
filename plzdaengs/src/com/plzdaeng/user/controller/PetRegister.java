package com.plzdaeng.user.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.plzdaeng.dto.*;
import com.plzdaeng.user.service.PetService;
import com.plzdaeng.util.*;

@WebServlet("/petregister")
public class PetRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service;
	
    public PetRegister() {
        super();
        service = new PetService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("petregister");
		String saveDirectory = SiteConstance.IMG_PATH;
		UserDto user = (UserDto)request.getSession().getAttribute("userInfo");
		// 테스트용
		if(user == null) {
			user = new UserDto();
			user.setUser_id("calubang");
		}
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, "utf-8");
		
		String petName = mr.getParameter("petname");
		String breedcode = mr.getParameter("breedcode");
		String petgender = mr.getParameter("petgender");
		String birthdate = mr.getParameter("birthdate");
		String pettype = mr.getParameter("pettype");
		String animalcode = mr.getParameter("animalcode");
		
		String[] vaccincodes = mr.getParameterValues("vaccincode");
		String[] vaccindates = mr.getParameterValues("vaccindate");
		
		PetDto pet = new PetDto();
		
		pet.setUserDto(user);
		pet.setPet_name(petName);
		pet.setBreedDto(new BreedDto(new AnimalDto(animalcode), breedcode, null));
		pet.setPet_gender(petgender);
		pet.setBirth_date(birthdate);
		if(pettype != null) {
			pet.setPet_type(pettype);
		}else {
			pet.setPet_type("F");
		}
		//첫번째 펫이라면.. 자동 대표펫
		List<PetDto> petList = (List<PetDto>)request.getSession().getAttribute("petList");
		if(petList == null || petList.size() == 0) {
			pet.setPet_type("T");
		}
		
		//이미지 부분
		File profileFile = mr.getFile("imgdata");
		if(profileFile == null) {
			pet.setPet_img("/plzdaengs/template/img/basic_pet_profile.jpg");
		}else {
			pet.setPet_img("/plzdaengs/img/"+user.getUser_id()+ "/"+pet.getPet_name() + "." + profileFile.getName().split("\\.")[1]);
		}
		
		List<TakeVaccinDto> takeVaccinList = new ArrayList<TakeVaccinDto>();
		for(int i=0; i<vaccincodes.length; i++) {
			if(vaccincodes[i] != null && !vaccincodes[i].equals("")) {
				TakeVaccinDto takeVaccinDto = new TakeVaccinDto();
				VaccinationDto vaccinationDto = new VaccinationDto();
				vaccinationDto.setVaccin_code(vaccincodes[i]);
				takeVaccinDto.setVaccinationDto(vaccinationDto);
				takeVaccinDto.setTakeVaccinDate(vaccindates[i]);
				takeVaccinList.add(takeVaccinDto);
			}
		}
		pet.setTakeVaccinList(takeVaccinList);
		
		//System.out.println(pet.getTakeVaccinList());
		//System.out.println(pet);
		
		
		int result = service.petRegister(pet);
		if(result == 1 && profileFile != null) {
			String path = request.getServletContext().getRealPath("/img");
			ProfileCreate.profileRegister(profileFile, path , user.getUser_id(), pet.getPet_name() , "pet");
		}
		request.setAttribute("result", result);
		//System.out.println(result);
		
		String path = "/user/result/result.jsp";
		MoveUrl.forward(request, response, path);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
