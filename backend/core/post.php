<?php

class Event
{
    //db suff
    private $conn;
    private $table = 'events';
    private $dates_table = 'eventsRoute';

    // posts properties
    public $id;
    public $title;
    public $description;
    public $adult_price;
    public $kid_price;
    public $pier_price;


    //constuctor with db connection
    public function __construct($db)
    {
        $this->conn = $db;
    }
    // getting posts from database
    /**
     * Take all event from database
     *
     * @return PDOStatement
     */
    public function read()
    {
        //create query
        $query = 'SELECT
            e.id,
            e.title,
            e.description,
            e.adult_price,
            e.kid_price,
            e.pier_price
            FROM
            ' . $this->table . ' e
            ';

        //prepare statement
        $stmt = $this->conn->prepare($query);
        //execute query
        $stmt->execute();
        return $stmt;
    }

    public function read_single()
    {
        $query = 'SELECT
            e.id,
            e.title,
            e.description,
            e.adult_price,
            e.kid_price,
            e.pier_price
            FROM
            ' . $this->table . ' e
            WHERE e.id = ? LIMIT 1';

        //prepare statement
        $stmt = $this->conn->prepare($query);
        //binding param
        $stmt->bindParam(1, $this->id);
        //execute the query
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        $this->title = $row['title'];
        $this->description = $row['description'];
        $this->adult_price = $row['adult_price'];
        $this->kid_price = $row['kid_price'];
        $this->pier_price = $row['pier_price'];
    }
}

class Order
{
    private $conn;
    private $table = 'Orders';


    // posts properties
    public $id;
    public $event_id;
    public $event_date_forward;
    public $event_date_back;
    public $ticket_adult_price;
    public $ticket_adult_quanity;
    public $ticket_kid_price;
    public $ticket_kid_quanity;
    public $equal_price;
    public $created_time;
    public $group_ticket;
    public $preferential_ticket;


    //constuctor with db connection
    public function __construct($db)
    {
        $this->conn = $db;
    }
    // getting posts from database
    /**
     * Take all event from database
     *
     * @return PDOStatement
     */

    public function create()
    {

        $query = 'INSERT INTO ' . $this->table . ' SET event_id = :event_id , event_date_forward = :event_date_forward ,  ' . ($this->event_date_back ? 'event_date_back = :event_date_back ,' : '') . ' 
            ticket_adult_price = :ticket_adult_price , ticket_adult_quanity = :ticket_adult_quanity , ticket_kid_price = :ticket_kid_price ,
            ticket_kid_quanity = :ticket_kid_quanity , equal_price = :equal_price , created_time = :created_time , group_ticket = :group_ticket , preferential_ticket = :preferential_ticket';



        $stmt = $this->conn->prepare($query);

        $this->event_id = htmlspecialchars(strip_tags($this->event_id));
        $this->event_date_forward = htmlspecialchars(strip_tags($this->event_date_forward));
        $this->event_date_back = htmlspecialchars(strip_tags($this->event_date_back));
        $this->ticket_adult_price = htmlspecialchars(strip_tags($this->ticket_adult_price));
        $this->ticket_adult_quanity = htmlspecialchars(strip_tags($this->ticket_adult_quanity));
        $this->ticket_kid_price = htmlspecialchars(strip_tags($this->ticket_kid_price));
        $this->ticket_kid_quanity = htmlspecialchars(strip_tags($this->ticket_kid_quanity));
        $this->equal_price = htmlspecialchars(strip_tags($this->equal_price));
        $this->created_time = htmlspecialchars(strip_tags($this->created_time));
        $this->group_ticket = htmlspecialchars(strip_tags($this->group_ticket));
        $this->preferential_ticket = htmlspecialchars(strip_tags($this->preferential_ticket));


        $stmt->bindParam(':event_id', $this->event_id);
        $stmt->bindParam(':event_date_forward', $this->event_date_forward);
        $this->event_date_back ? $stmt->bindParam(':event_date_back', $this->event_date_back) : null;
        $stmt->bindParam(':ticket_adult_price', $this->ticket_adult_price);
        $stmt->bindParam(':ticket_adult_quanity', $this->ticket_adult_quanity);
        $stmt->bindParam(':ticket_kid_price', $this->ticket_kid_price);
        $stmt->bindParam(':ticket_kid_quanity', $this->ticket_kid_quanity);
        $stmt->bindParam(':equal_price', $this->equal_price);
        $stmt->bindParam(':created_time', $this->created_time);
        $stmt->bindParam(':group_ticket', $this->group_ticket);
        $stmt->bindParam(':preferential_ticket', $this->preferential_ticket);

        if ($stmt->execute()) {
            return true;
        }

        printf("Error %s. \n", $stmt->error);
        return false;
    }
}
