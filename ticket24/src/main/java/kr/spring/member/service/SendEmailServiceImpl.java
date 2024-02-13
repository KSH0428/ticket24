package kr.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.MailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class SendEmailServiceImpl implements SendEmailService{
	@Autowired
	private MemberService memberService;
	@Autowired
    private JavaMailSender mailSender;
    private static final String FROM_ADDRESS = "zewntlr78@gmail.com";

    //회원가입 이메일 인증
    public MailVO createMailconfirmEmail(String mem_email, String code){
        MailVO vo = new MailVO();
        vo.setAddress(mem_email);
        vo.setTitle("<티켓24> 회원가입 인증 메일 입니다.");
        vo.setMessage("안녕하세요. 티켓24입니다. 입력하실 인증번호는 "  + code + " 입니다.");

        log.debug("<<이메일 발송 진입확인>>");
        return vo;
    }
    
    //비밀번호 찾기 이메일
    public MailVO createMailAndChangePassword(String mem_email, String mem_name, String mem_id){
        
    	String str = getTempPassword();
        MailVO vo = new MailVO();
        vo.setAddress(mem_email);
        vo.setTitle("<티켓24> " + mem_name + " 님의 임시비밀번호 안내 이메일 입니다.");
        vo.setMessage("안녕하세요. 티켓24입니다. 임시비밀번호 안내 이메일 드립니다." + "[" + mem_name + "]" +"님의 임시 비밀번호는 "
        + str + " 입니다.");
        
        updatePassword(str,mem_email,mem_name,mem_id);
        log.debug("<<비밀번호변경 진입확인>>");
        return vo;
    }

    public void updatePassword(String str, String mem_email,String mem_name,String mem_id){
        String new_passwd = str;
        String email = memberService.selectMemberPw(mem_id, mem_name, mem_email).getMem_email();
        log.debug("<<이메일>> : " + email);
        memberService.updateUserPassword(email,new_passwd);
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
    
    //이메일 발송
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