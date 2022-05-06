<?php
/*
TODO: Further examine the cURL call, since it seems to tend running wild, which could lead to server overload!
*/
echo get_file_content('http://google.de');

function get_file_content($url, $forceCURL = false)
{
	$internalServerURL = 'http://' . $_SERVER['SERVER_NAME'];
	$internalSecureServerURL = 'https://' . $_SERVER['SERVER_NAME'];

	$externalURL = strpos('http', $url) === 0 && !(strpos($internalServerURL, $url) === 0 || strpos($internalSecureServerURL, $url) === 0);

	if($externalURL && !ini_get('allow_url_fopen'))
	{
		return 'ERROR: Reading content from external URLs is not allowed on this server. Please contact your administrator or provider to resolve this issue!';
	}

	if(!defined('CONTENTMETHOD'))
	{
		$contentMethod = false;
		if(file_get_contents(__FILE__))
		{
			$contentMethod = 'file';
		}
		else if(function_exists('curl_version'))
		{
			$contentMethod = 'curl';
		}
		define('CONTENTMETHOD', $contentMethod);
	}
	if(!CONTENTMETHOD)
	{
		return false;
	}
	$content = '';
	if(CONTENTMETHOD === 'file' && !$forceCURL)
	{
		$content = file_get_contents($url);
	}
	else
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$content = curl_exec($ch);
		curl_close($ch);
	}
	return $content;
}
?>

<script src="https://unpkg.com/vue@3"></script>

<div id="app">{{ message }}</div>

<script>
  Vue.createApp({
    data() {
      return {
        message: 'Hello Vue!'
      }
    }
  }).mount('#app')
</script>



<script type="importmap">
  {
    "imports": {
      "vue": "https://unpkg.com/vue@3/dist/vue.esm-browser.js"
    }
  }
</script>

<div id="app">{{ message }}</div>

<script type="module">
  import { createApp } from 'vue'

  createApp({
    data() {
      return {
        message: 'Hello Vue!'
      }
    }
  }).mount('#app')
</script>
