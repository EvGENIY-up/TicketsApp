<?php
//headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

//initializing our api
include_once('../core/initialize.php');

//instantiate post

$post = new Event($db);

//blog post query
$result = $post->read();
//get the row count
$num = $result->rowCount();

if ($num > 0) {
    $post_arr = [];
    $post_arr['data'] = [];

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) { // $row - один пост

        $date_query = 'SELECT
            r.time,
            r.route
            FROM
            eventsRoute AS r 
            WHERE r.event_id = ' . $row['id'] .
            ' ORDER BY r.route ';
        $dates_stmt = $db->prepare($date_query);
        $dates_stmt->execute();
        $dates = $dates_stmt->fetchAll(PDO::FETCH_ASSOC);

        $post_item = array(
            'id' => $row['id'],
            'title' => $row['title'],
            'description' => $row['description'],
            'adult_price' => $row['adult_price'],
            'kid_price' => $row['kid_price'],
            'pier_price' => $row['pier_price'],
            'dates' => $dates,
        );
        array_push($post_arr['data'], $post_item);
    }
    // push to "data"
    echo json_encode($post_arr);
    //convert to JSON and output
} else {
    echo json_encode(array('message' => 'No posts found.'));
}
