<?php
declare(strict_types=1);

namespace App\Controller;

use Cake\Http\Client;

class TokenController extends AppController{

    public function index(){
        $token = null;

        if($this->request->is('post'))
        {
            $http = new Client();
            $response = $http->post('http://keycloak:8080/realms/gradeHoraria/protocol/openid-connect/token', [
                'username' => $this->request->getData('username'),
                'password' => $this->request->getData('password'),
                'grant_type' => 'password',
                'client_id' => 'api_subjects',
                'client_secret' => 'VuQ7HevnRgn50lXd29A6lY3igyqf8XN2'
            ]);

            $token = $response->getJson();
        }

        $this->set('token', $token);
    }
}
