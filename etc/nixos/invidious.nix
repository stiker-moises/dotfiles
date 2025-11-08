{ config, pkgs, ... }:
{
networking.firewall.allowedTCPPorts = [ config.services.invidious.port ];
services.invidious = {
	enable = true;
	address = "0.0.0.0";
	sig-helper.enable = true;
	sig-helper.listenAddress = "0.0.0.0:2999";
	port = 8090;
	database = {
		createLocally = true;
	};
	settings = {
		visitor_data = "CgtiQVNNSjdSazlaOCjft_a7BjIKCgJVUxIEGgAgTg%3D%3D";
		po_token = "MnR7rjq-fnKr1nuW6J0CXRKpheQvsOTNv2dKXOBVSEvtlM91GD6m2_4HKxRVP_qQZXc7wBUYdlVWrVw9anxo7X99FJWY0Hb9D2MKxPA2V1m5gXaMTAPddpTAOYqe2WQsvG7ve6yw2VtNwrurHhVnrqMtdzuS3g==";
#		external_port = 443;
		https_only = false;
		use_quic = true;
		nginx.enable = false;
		statistics_enabled = false;
		registration_enabled = false;
		login_enabled = true;
		captcha_enabled = false;
		enable_user_notifications = true;
		use_innertube_for_captions = false;
#		admins = [ ];
#		use_pubsub_feeds = false;
#		channel_refresh_interval = "15m";
		cache_annotations = true;
	};
};
}
