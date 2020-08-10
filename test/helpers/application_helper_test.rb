require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "identifies the /publisher namespace from a full URL" do
    request = ActionDispatch::TestRequest.create
    request.path = "/publisher/cards/overlay_inspiration_cards/b922dd17-07dd-4755-b38c-fef91508a089"
    assert in_namespace?(request, "publisher")
  end

  test "does not identify the /publisher namespace when in a /library URL" do
    request = ActionDispatch::TestRequest.create
    request.path = "/library/artefacts/images/c3f71e6c-6d05-4454-867b-63313b2334a9"
    refute in_namespace?(request, "publisher")
  end
  
  test "removes the http/https protocol prefix if accidentally found" do
    request = ActionDispatch::TestRequest.create
    request.path = "https://localhost:3000/publisher/cards/overlay_inspiration_cards/b922dd17-07dd-4755-b38c-fef91508a089"
    assert in_namespace?(request, "publisher")
  end

end
