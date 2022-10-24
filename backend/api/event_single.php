<?php
//headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

//initializing our api
include_once('../core/initialize.php');

//instantiate post

$post = new Event($db);

$post->id = isset($_GET['id']) ? $_GET['id'] : die();
$post->read_single();

$post_arr = array(
    'id' => $post->id,
    'title' => $post->title,
    'description' => $post->description,
    'adult_price' => $post->adult_price,
    'kid_price' => $post->kid_price,
    'pier_price' => $post->pier_price,
);

// make a json
print_r(json_encode($post_arr));
