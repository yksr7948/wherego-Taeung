package com.go.wherego.entertain.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.wherego.entertain.model.service.EntertainService;
import com.go.wherego.entertain.model.vo.WC;
import com.go.wherego.member.model.service.MemberService;
import com.go.wherego.member.model.vo.Member;
import com.go.wherego.trip.model.vo.Trip;
import com.google.gson.Gson;



@Controller
public class EntertainController {
	
	@Autowired
	private EntertainService entertainService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("worldcup.en")
	public String startWorldCup(Model model) {
		ArrayList<Trip> list = entertainService.getTop100();
		  //System.out.println("처 음"+list); 
		  model.addAttribute("list",new Gson().toJson(list));
		return "entertain/worldcup";
	}
	
	@RequestMapping("rullet.en")
	public String startRullet(Model model) {
		/*
		 * ArrayList<Trip> list = entertainService.getTop100();
		 * System.out.println("처 음"+list); model.addAttribute("list",new
		 * Gson().toJson(list));
		 */
	return "entertain/rullet";
	}
	
	/*
	 * @RequestMapping("passGang") 
	 * public String selectGang(Model model, String gang) { 
	 * ArrayList<Trip> list = entertainService.getTop100();
	 * System.out.println("처 음"+list); 
	 * model.addAttribute("list",new Gson().toJson(list));
	 * }
	 */

	// 가져온 Trip 랜덤으로 섞어서 입력한 개수만큼 뽑아오기 
//	public static ArrayList<Trip> makeRandom(ArrayList<Trip> list, int gang) {
//
//        Random random = new Random();
//        Set<Trip> selectedElements = new HashSet<>();
//        ArrayList<Trip> resultList = new ArrayList<>();
//
//        while (selectedElements.size() < gang) {
//            int randomIndex = random.nextInt(list.size());
//            Trip trip = list.get(randomIndex);
//            if (selectedElements.add(trip)) {
//                resultList.add(trip);
//            }
//        }
//        
//        return resultList;
//    }
	
	@PostMapping("wcResult.en")
	public String insertWcResult(String userId,String winnerName,String check,Model model) {
		int flag=Integer.parseInt(check);
		/*
		 * if(userId==null) { if(flag==0) { return "entertain/index"; }else { return
		 * "entertain/ranking" ; } }
		 */
		Member m = memberService.getMemberById(userId);
		System.out.println(m.getTagWords());
		WC wc = new WC();
		wc.setUserId(userId);
		wc.setAge(m.getAge());
		wc.setTitle(winnerName);
		wc.setMBTI(m.getMBTI());
		wc.setTagWords(m.getTagWords());
		wc.setGender(m.getGender());
		System.out.println(wc);
		entertainService.insertWCResult(wc);
		if(flag==0) {
			System.out.println("결승전 끝, 우승자는 : "+winnerName+" check : "+check+" 다시하기");
			ArrayList<Trip>  list = entertainService.getTop100();
			model.addAttribute("list",new Gson().toJson(list));
			return "entertain/worldcup";
		}else {
			System.out.println("결승전 끝, 우승자는 : "+winnerName+" check : "+check+" 랭킹보기");
			return "entertain/ranking";
		}
	}
	
	
	
	
	
	
}
