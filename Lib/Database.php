<?php

/**
* Default functions to use Database
*/
class ClassName extends PDO
{
	
	function __construct()
	{
		parent::__construct('mysql:host=localhost;dbname=CPRO', 'usrAppCPRO', 'pass');
	}
}

?>