package kr.co.sist.admin.acc;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommodationDomain {

    private String main_img;
    private String acm_name;
    private String fcl_type;
    private String admin_phone_number;
    private String address;
    private String detail_address;
    private String description;
    private String content;
    private String acm_type;
    private String fcl_name;
    private String sub_img_name;
    private int acm_type_id;
    private int acm_id;
    private double longitude;
    private double latitude;
    
    // 서브 이미지와 콘텐츠 정보
    private List<String> sub_img_names = new ArrayList<>();
    private List<String> contents = new ArrayList<>();

    // 시설 정보
    private List<String> fcl_names = new ArrayList<>();
}
