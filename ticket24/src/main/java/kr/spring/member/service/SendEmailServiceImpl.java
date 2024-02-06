package kr.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.MailVO;
import lombok.AllArgsConstructor;

@Service
@Transactional
@AllArgsConstructor
public class SendEmailServiceImpl implements SendEmailService{
	@Autowired
	private MemberService memberService;

    private JavaMailSender mailSender;
    private static final String FROM_ADDRESS = "zewntlr78@gmail.com";

    public MailVO createMailAndChangePassword(String mem_email, String mem_name, String mem_id){
        String str = getTempPassword();
        MailVO vo = new MailVO();
        vo.setAddress(mem_name);
        vo.setTitle(mem_name+"님의 임시비밀번호 안내 이메일 입니다.");
        vo.setMessage("안녕하세요. 임시비밀번호 안내 관련 이메일 입니다." + "[" + mem_name + "]" +"님의 임시 비밀번호는 "
        + str + " 입니다.");
        updatePassword(str,mem_email,mem_name,mem_id);
        return vo;
    }

    public void updatePassword(String str, String mem_email,String mem_name,String mem_id){
        String passwd = str;
        String email = memberService.selectMemberPw(mem_id, mem_name, mem_email).getMem_email();
        memberService.updateUserPassword(email,passwd);
    }

    public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        return str;
    }
    
    public void mailSend(MailVO vo){
        System.out.println("이메일 전송 완료!");
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(vo.getAddress());
        message.setFrom(SendEmailServiceImpl.FROM_ADDRESS);
        message.setSubject(vo.getTitle());
        message.setText(vo.getMessage());

        mailSender.send(message);
    }
}