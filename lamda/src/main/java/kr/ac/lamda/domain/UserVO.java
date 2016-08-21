package kr.ac.lamda.domain;

import java.util.Date;

public class UserVO {

  private int seq;
  private String user_id;
  private String password;
  private String email;
  private Date join_date;
  private Date drop_date;
  private String likelang;
  private String img_url;
  private int errorcnt;
  private Date banned_date;
  

  public int getSeq() {
	return seq;
}


public void setSeq(int seq) {
	this.seq = seq;
}


public String getUser_id() {
	return user_id;
}


public void setUser_id(String user_id) {
	this.user_id = user_id;
}


public String getPassword() {
	return password;
}


public void setPassword(String password) {
	this.password = password;
}


public String getEmail() {
	return email;
}


public void setEmail(String email) {
	this.email = email;
}


public Date getJoin_date() {
	return join_date;
}


public void setJoin_date(Date join_date) {
	this.join_date = join_date;
}


public Date getDrop_date() {
	return drop_date;
}


public void setDrop_date(Date drop_date) {
	this.drop_date = drop_date;
}


public String getLikelang() {
	return likelang;
}


public void setLikelang(String likelang) {
	this.likelang = likelang;
}


public String getImg_url() {
	return img_url;
}


public void setImg_url(String img_url) {
	this.img_url = img_url;
}


public int getErrorcnt() {
	return errorcnt;
}


public void setErrorcnt(int errorcnt) {
	this.errorcnt = errorcnt;
}


public Date getBanned_date() {
	return banned_date;
}


public void setBanned_date(Date banned_date) {
	this.banned_date = banned_date;
}


@Override
  public String toString() {
    return "UserVO [seq=" + seq + ", user_id=" + user_id + ", password=" + password + ", email=" + email + 
    		", join_date=" + join_date + ", drop_date=" + drop_date + ", likelang=" + likelang + ", img_url=" + img_url + 
    		", errorcnt=" + errorcnt + ", banned_date=" + banned_date + "]";
  }
}
