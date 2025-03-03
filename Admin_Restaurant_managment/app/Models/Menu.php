<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'prix', 'description', 'image', 'categorie_id'];
    protected $casts = [
        'prix' => 'float'
    ];
    public function menu()
    {
        return $this->belongsTo(Categories::class);
    }
    public function details_commande()
    {
        return $this->hasMany(DetailsCommandes::class);
    }
}
