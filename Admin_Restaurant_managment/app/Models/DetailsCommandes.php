<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailsCommandes extends Model
{
    use HasFactory;

    protected $fillable = ['commande_id', 'produit_id', 'quantite', 'notes'];

    protected $casts = [
        'quantite' => 'integer'
    ];

    public function commande()
    {
        return $this->belongsTo(Commandes::class);
    }

    public function produit()
    {
        return $this->belongsTo(Menu::class);
    }

}
