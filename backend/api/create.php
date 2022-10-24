<?php
//headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');
header('Access-Controll-Allow-Methods: POST');
header('Access-Controll-Allow-Headers:Access-Controll-Allow-Headers,Content-Type,Access-Controll-Allow-Methods,X-Requested-With');

//initializing our api
include_once('../core/initialize.php');

//instantiate post

$order = new Order($db);


$data = json_decode(file_get_contents("php://input"));

$order->event_id = $data->event_id;
$order->event_date_forward = $data->event_date_forward;
$order->event_date_back = $data->event_date_back;
$order->ticket_adult_price = $data->ticket_adult_price;
$order->ticket_adult_quanity = $data->ticket_adult_quanity;
$order->ticket_kid_price = $data->ticket_kid_price;
$order->ticket_kid_quanity = $data->ticket_kid_quanity;
$order->equal_price = $data->equal_price;
$order->created_time = $data->created_time;
$order->group_ticket = $data->group_ticket;
$order->preferential_ticket = $data->preferential_ticket;

if ($order->create()) {
    echo json_encode(
        array('message' => 'Post created')
    );
} else {
    echo json_encode(
        array('message' => 'Post not created')
    );
}
