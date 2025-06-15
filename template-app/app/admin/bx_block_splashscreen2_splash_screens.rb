ActiveAdmin.register BxBlockSplashscreen2::SplashScreen, as: "Splash Screen" do
  permit_params :title, :video

  form title: 'Splash Screen' do |f|
    inputs 'Details' do
      input :video, as: :file
    end
    f.actions
  end

  show do |splash_screen|
    attributes_table do
      row :id
      row :video do |v|
        div :class => 'col-xs-4' do
          video_tag(url_for(v.video), size: "200x150", controls: true) rescue :nil
        end
      end
    end
  end

  index do
    selectable_column
    column :id
    column :video do |splash_screen|
      video_tag(url_for(splash_screen.video), size: "200x150", controls: true) rescue :nil
    end
    actions
  end
end
