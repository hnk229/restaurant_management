<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'prix',
        'description',
        'image',
        'user_id'];
    protected $casts = [
        'prix' => 'float'
    ];

    // Relation avec l'utilisateur qui a ajouté le menu
    public function user() {
        return $this->belongsTo(User::class);
    }
    // Relation many-to-many avec les catégories
    public function categories() {
        return $this->belongsToMany(Categories::class, 'category_menu');
    }

    public function details_commande()
    {
        return $this->hasMany(DetailsCommandes::class);
    }
}
