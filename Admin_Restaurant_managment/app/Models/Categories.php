<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Categories extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'image',
        'user_id',
    ];
    public function menus() {
        return $this->belongsToMany(Menu::class, 'category_menu');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
