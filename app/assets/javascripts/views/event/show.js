Indie.Views.EventShow = Backbone.View.extend({
  templateNew: JST['event/show'],
  events: {
    'click .glyphicon-pencil.glyphicon': "editEvent",
    'click .btn-contribute': 'fundEvent',
    'click .glyphicon.glyphicon-plus.add-perk': 'newPerk',
    'click .btn.btn-success.create-perk': 'createPerk',
    'click .close.perk-destroyer': 'destroyPerk',
  },

  destroyPerk: function(event){
    var that = this;
    $('.add-perk-container').html('<span class="glyphicon glyphicon-plus add-perk"></span>')
    this.perks.get(event.toElement.dataset.id).destroy({
      success: function(){
        that.render();
      }
    })

  },

  createPerk: function(event){
    $('.add-perk-container').html('<span class="glyphicon glyphicon-plus add-perk"></span>')
    var that = this;
    var perk = new Indie.Models.Perk($(event.target.form).serializeJSON());
    perk.set('event_id', this.event.get('id'));
    perk.save([], {
      success: function(){
        that.perks.add(perk);

        $('.perks-col').append(JST['perk/show']({perk: perk, is_owned: true}));
        // Indie.router.showEvent(that.event.get('id'));
      }
    });
  },
  newPerk: function(event){
    var $el = $('.add-perk-container')
    $el.html(JST['perk/new']({}))
  },
  initialize: function(options){
    this.event = options.event
    this.perks = options.perks
    this.event.on('change add reset sync', this.render, this);
  },
  fundEvent: function(event){
    console.log('fund')
    var fundsToAdd = $('.contribution-field').val();
    var $ar = $('#amount-raised')
    var originalValue = parseInt($ar.html())
    $ar.html(parseInt($ar.html())+parseInt(fundsToAdd))
    this.event.set('funds_raised', this.event.get('funds_raised')+parseInt(fundsToAdd));
    this.event.set('session_token', Cookie.get('session_token'))
    this.event.save();
  },
  // clean this up!
  editEvent: function(event){
    this.render();
    var that = this;
    var attr = event.currentTarget.dataset['attr']
    var $el = $("span[data-attr="+attr+"]").parent();

    // sets length of input box
    var rows = 3;
    if(this.event.get(attr)){
      rows = this.event.get(attr).length/60;
    }

    $el.html('<textarea autofocus id="edit-attr-field" rows="'+rows+'"" type="text">'+this.event.get(attr)+'</textarea>')
    $el.children()[0].select()
    $el.keydown(function(event){
      if(event.keyCode === 13){
        event.preventDefault()
        that.event.set(attr, $('#edit-attr-field').val())
        that.event.set('session_token', Cookie.get('session_token'))
        that.event.save();
      }
    })

    console.log(this.event)
  },
  render: function(){
    console.log('render',this.event)

    var renderedContent = this.templateNew({
      event: this.event,
      perks: this.perks
    });

    this.$el.html(renderedContent)
    return this;
  },
})
