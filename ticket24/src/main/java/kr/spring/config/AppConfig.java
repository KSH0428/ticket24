package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
import kr.spring.websocket.SocketHandler;
//자바코드 기반 설정 클래스
@Configuration
@EnableWebSocket
public class AppConfig implements WebMvcConfigurer, WebSocketConfigurer{
	private AutoLoginCheckInterceptor autoLoginCheck;
	private LoginCheckInterceptor loginCheck;
	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLoginCheck = new AutoLoginCheckInterceptor();
		return autoLoginCheck;
	}
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//AutoLoginCheckInterceptor 설정
		registry.addInterceptor(autoLoginCheck)
				.addPathPatterns("/**")
				.excludePathPatterns("/member/login")
				.excludePathPatterns("/member/logout");
		//LoginCheckInterceptor 설정
		registry.addInterceptor(loginCheck)
		        .addPathPatterns("/member/myPage")
		        .addPathPatterns("/member/update")
		        .addPathPatterns("/member/withdraw")
		        .addPathPatterns("/member/withdraw")
		        .addPathPatterns("/member/passwdUpdate")
		        .addPathPatterns("/member/point")
		        .addPathPatterns("/comm/write")
		        .addPathPatterns("/comm/update")
		        .addPathPatterns("/comm/delete")
		        .addPathPatterns("/ticket/write")
		        .addPathPatterns("/ticket/update")
		        .addPathPatterns("/ticket/delete")
				.addPathPatterns("/question/write")
				.addPathPatterns("/question/update")
				.addPathPatterns("/question/delete")
				.addPathPatterns("/question/adminWrite")
				.addPathPatterns("/question/adminUpdate")
				.addPathPatterns("/question/adminDelete")
				.addPathPatterns("/faq/write")
				.addPathPatterns("/faq/update")
				.addPathPatterns("/faq/delete")
				.addPathPatterns("/chat/chatDetail")
				.addPathPatterns("/chat/writeChat")
				.addPathPatterns("/chat/chatDetailAjax")
				.addPathPatterns("/chat/deleteChat")
				.addPathPatterns("/event/write")
				.addPathPatterns("/event/detail")
				.addPathPatterns("/event/update")
				.addPathPatterns("/event/delete");
	} 
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = new TilesConfigurer();
		//tilesdef.xml의 경로와 파일명 지정
		configurer.setDefinitions(
			 new String[] {
					 "/WEB-INF/tiles-def/main.xml",
					 "/WEB-INF/tiles-def/ysw.xml",
					 "/WEB-INF/tiles-def/ceh.xml",
					 "/WEB-INF/tiles-def/ces.xml",
					 "/WEB-INF/tiles-def/cmj.xml",
					 "/WEB-INF/tiles-def/hjh.xml",
					 "/WEB-INF/tiles-def/ksh.xml"
					 });
		configurer.setCheckRefresh(true);
		return configurer;
	}
	
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}

	//웹소켓 셋팅
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
																//허용 도메인 지정
		registry.addHandler(new SocketHandler(), "message-ws").setAllowedOrigins("*");
	}	
}








