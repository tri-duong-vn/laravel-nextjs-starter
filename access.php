<?php

$host = 'db';
$ports = array(80, 443, 3306);

foreach ($ports as $port)
{
    $connection = fsockopen($host, $port, $errno, $errstr);
    if (is_resource($connection))
    {
        echo '<h2>' . $host . ':' . $port . ' ' . '(' . getservbyport($port, 'tcp') . ') is open.</h2>' . "\n";
        fclose($connection);
    }
    else
    {
         echo '<h2>Error: ' . $errno . ' ' . $errstr . '</h2>' . "\n";
    }
}
