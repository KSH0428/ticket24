package kr.spring.payment.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class PaymentController {
	private final IamportClient iamportClient;

    public PaymentController() {
        this.iamportClient = new IamportClient("8012382737075285",
                "4mXlBUs4z22UMt2qmzEQdfjABCnu5l4VlPJ1z2xSxmJBNQAV6GK1oJ9JwkBOUrIx1Nqaydq2HgqR2cIy");
    }

    @ResponseBody
    @RequestMapping("/verify/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable("imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        return iamportClient.paymentByImpUid(imp_uid);
    }
    
}
