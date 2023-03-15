describe("Adding a product to cart", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000/");
    cy.get(".btn").as("cartCount"); // assign the cart count element to a Cypress alias for easier use
  });

  it('should increase the cart count when clicking the "Add to Cart" button', () => {
    cy.get('[data-cy="add-to-cart"]').first().click({ force: true }); // click 
    cy.get(":nth-child(1) > div > .button_to > .btn").click({ force: true });
    // assert that the cart size has increased by 1
    cy.get(".nav-item.end-0").should("contain", "My Cart (1)");
  });
});
