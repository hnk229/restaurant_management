<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Commandes extends Model
{
    use HasFactory;

    protected $fillable = [
        'serveur_id',
        'date_commande',
        'statut'
    ];

    public function serveur()
    {
        return $this->belongsTo(User::class, 'serveur_id');
    }

    public function details(){
        return $this->hasMany(DetailsCommandes::class);
    }

}
