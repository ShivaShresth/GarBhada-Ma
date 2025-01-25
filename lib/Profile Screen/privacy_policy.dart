import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Tulips Technologies Pvt.Ltd. built the Ghar-Bhadama app as a Free app. This Service is provided by NQ Technologies Pvt.Ltd. at no cost and is intended for use as is."),
              SizedBox(
                height: 20,
              ),
              Text(
                  "This page is used to inform visitors regarding our policies with the collection, use, and discloure of Personal Information if anyone decided to use our Service."),
              SizedBox(
                height: 20,
              ),
              Text(
                  "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal information that we collect is used for providing and improving the service. We will not use or share your information with anyone except as described in this Privacy Policy."),
              SizedBox(
                height: 20,
              ),
              Text(
                  "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Gar-Bhadama unless otherwise defined in this Privacy Policy."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Information Collection and Use",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "For a better experience, while using our service, we may required you to provided us with certain personally identifiable information, including but not limited to location, device id. The information that we request wil be retained by us and use as described in this privacy policy. All inofrmation collected is only used to enhance the service offered to you and is not shared or sold to any third parites. The information is not used for anything else."),
              SizedBox(
                height: 20,
              ),
              Text(
                  "The app does use third party service that may collect information used to identify you."),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Link to privacy policy of third party service providers used by the app."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(".Google Play Services")),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Cookies",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Cookies are files with a small amount data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these cookies explicitly. However, the app may use third party code and libraries that use cookies to collect information and improve their services. You have the option to either accept or refuse these cookies and known when a cookie is being sent to your device. If you chose to refuse our cookies, you may not be able to use some portions of this Service."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Service Providers",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "We may employ third-party companies and individuals due to the following reasons:"),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(".To Facilitate our Service;")),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(".To provide the Service on our behalf;")),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(".To perform Service-relatted services; or")),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      ".To assist us in analysing how our Services is used.")),
              SizedBox(
                height: 20,
              ),
              Text(
                  "We want to inform users of this Services that thes thrid parties have access to your Personal information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Security",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "We value your trust in providing us your personal information, thus we are striving to use commerically acceptable means of proteching it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot gurantee its absolute security."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Link to Other Sites",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "This Service may contain links to other sites. If you cokc on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any thrid-party sites or services."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Children's Privacy",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "These Servics do not address anyone under the age of 13. We do not knowingly collect personally idenifiable information from childrne under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessar actions."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Changes to This Privacy Policy",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any chanes. We will notify you of any chanes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page."),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  "If you have any questions or suggestions about our Privaccy Policy, do not hesitate to contact us.")
            ],
          ),
        ),
      ),
    );
  }
}
