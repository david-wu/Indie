window.Indie.Routers.Main = Backbone.Router.extend({
  routes: {
    '': 'explore',
    'explore': 'explore',
    'events/:id': 'showEvent',
    'user/new': 'signUp',
    'user/login': 'signUp',
    'user/logout': 'signOut',
    'event/new': 'newEvent',
  },
  initialize: function(){
    $navBarEl = $('#navBarEl');
    $mainEl = $('#mainEl');
    $footerEl = $('#footerEl');
    // API is secure
    this._currentUser = new Indie.Models.User({
      fname: Cookie.get('fname'),
      session_token: Cookie.get('session_token'),
      user_id: Cookie.get('user_id'),
    });
    this._events = new Indie.Collections.Events()
    this._generateNavBar(this._currentUser);
    this._generateFooter();
  },
  explore: function(){
    console.log('Router#Index')
    var view = new Indie.Views.Frame({
      collection: this._events
    });
    this._events.fetch({
      success: function(){
        view.render();
      }
    })
    this._swapView(view);
  },
  signUp: function(){
    var newUserView = new Indie.Views.NewUser();
    this._swapView(newUserView);
    newUserView.render();
  },
  signOut: function(){
    Cookie.delete('fname')
    Cookie.delete('session_token')
    Cookie.delete('user_id')
    this._currentUser = new Indie.Models.User();
    this.navigate('explore', {trigger: true});
    this._generateNavBar(this._currentUser);
  },
  newEvent: function(){
    if(!Cookie.get('session_token')){
      this.navigate('user/login', {trigger: true});
      return false;
    }

    var newEventView = new Indie.Views.NewEvent();
    this._swapView(newEventView);
    newEventView.render();
  },
  showEvent: function(id){
    if(this._events.get(id)){
      var event = this._events.get(id)
    }else{
      var event = new Indie.Models.Event({id:id})
    }
    var perks_col = new Indie.Collections.Perks();
    var eventShow = new Indie.Views.EventShow({
      event: event,
      perks: perks_col
    });
    event.fetch({
      success: function(response){
        console.log("fetched", response);
        var perks_arr = event.get("perks")
        if (perks_arr) {
          for(var i = 0; i < perks_arr.length; i++){
            perks_col.add(new Indie.Models.Perk(perks_arr[i]));
          }
        };        
      }
    });
    this._swapView(eventShow);
  },
  _generateNavBar: function(user){
    var barView = new Indie.Views.NavBar({
      user: user
    });
    this._swapNavBar(barView);
    barView.render();
  },
  _swapNavBar: function(navBarView){
    if (this._currentNavBar){
      this._currentNavBar.remove();
    }
    $navBarEl.html(navBarView.$el);
    this._currentNavBar = navBarView;
  },
  _generateFooter: function(){
    var footerView = new Indie.Views.Footer();
    this._swapFooter(footerView);
    footerView.render();
  },
  _swapFooter: function(footerView){
    if (this._currentFooter){
      this._currentFooter.remove();
    }
    $footerEl.html(footerView.$el);
    this._currentFooter = footerView;
  },
  _swapView: function(showView){
    if (this._currentView){
      this._currentView.remove();
    }
    $mainEl.html(showView.$el);
    this._currentView = showView
  },

})
