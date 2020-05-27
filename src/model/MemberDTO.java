package model;

import java.sql.Date;

/*
DTO객체(Data Transfer Object)
	: 데이터를 저장하기 위한 객체로 멤버변수, 생성자, getter/setter
	메소드를 가지고 있는 클래스로 일반벅인 자바빈(Been)규약을 따른다.
*/
public class MemberDTO {
	
	//멤버변수 : 정보은닉을 위해 private으로 선언함.
	private String id;
	private String pass;
	private String name;
	private Date regidate;
	
	//기본생성자
	public MemberDTO() {}
	
	//인자생성자
	public MemberDTO(String id, String pass, String name, Date regidate) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.regidate = regidate;
	}
	
	//getter/setter
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public java.sql.Date getRegidate() {
		return regidate;
	}

	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	
	
	/*
	 Object클래스에서 제공하는 메소드로 객체를 문자열형태로 변형해서
	 반환해주는 역할을 한다. toString()메소드를 오버라이딩하면
	 객체 자체를 그대로 print()하는 것이 가능하다.
	 */
	@Override
	public String toString() {
		return String.format("아이디 : %s, 비밀번호 : %s, 이름  : %s", 
				id, pass, name);
	}
	
}












