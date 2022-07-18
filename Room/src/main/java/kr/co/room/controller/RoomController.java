package kr.co.room.controller;

import java.io.File;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.co.room.model.Room;
import kr.co.room.pager.Pager;
import kr.co.room.service.RoomService;

@Controller
@RequestMapping("/room")
public class RoomController {
	
final String path = "room/";
	
	@Autowired
	RoomService service;	
	
	@RequestMapping("/list")
	String list(Model model, Pager pager) {
		pager.setPerPage(12);
		List<Room> list = service.list(pager);
		
		model.addAttribute("list", list);
		
		return path + "list";
	}

	@GetMapping("/add")
	String add() {
		return path + "add";
	}

	@PostMapping("/add")
	String add(Room item) {
		MultipartFile uploadFile = item.getAtchFileId();
		try {
			service.add(item);
			
			// String filename = uploadFile.getOriginalFilename();
			// String ext = filename.substring(filename.lastIndexOf(".") - 1, filename.length());
			String ext = "jpg";
			uploadFile.transferTo(new File("d:/upload/room_" + item.getRoomId() + "." + ext));			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return "redirect:list";
	}
	
	@GetMapping("/update/{roomId}")
	String update(@PathVariable int roomId, Model model) {
		Room item = service.item(roomId);
		
		model.addAttribute("item", item);
		
		return path + "update";
	}
	
	@PostMapping("/update/{roomId}")
	String update(@PathVariable int roomId, Room item) {
		item.setRoomId(roomId);
		
		MultipartFile uploadFile = item.getAtchFileId();
		try {
			//String filename = uploadFile.getOriginalFilename();
			//String ext = filename.substring(filename.lastIndexOf(".") - 1, filename.length());
			String ext = "jpg";
			uploadFile.transferTo(new File("d:/upload/room_" + item.getRoomId() + "." + ext));
			
			service.update(item);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return "redirect:../list";
	}
	
	@RequestMapping("/delete/{roomId}")
	String delete(@PathVariable int roomId) {
		service.delete(roomId);
		
		return "redirect:../list";
	}

}
